# frozen_string_literal: true

require "json"
require "openssl"
require "socket"
require "timeout"
require "uri"

module OpenAI::Test::MTLSWireHarness
  SERVER_TIMEOUT = 5
  MAX_HEADER_BYTES = 16 * 1024

  Identity = Data.define(:certificate, :key)
  RequestRecord = Data.define(
    :server_name,
    :request_line,
    :headers,
    :peer_certificate,
    :peer_certificate_chain,
    :handshake_error
  )
  ProxyRecord = Data.define(:authority, :headers)

  class PKI
    attr_reader :intermediate_certificate

    def initialize(hostnames:, client_names: [:a, :b])
      @serial = 0
      root_key = OpenSSL::PKey::RSA.new(2048)
      @root_certificate = issue_certificate(
        subject: "/CN=OpenAI Ruby mTLS test root",
        key: root_key,
        ca: true,
        path_length: 1
      )
      intermediate_key = OpenSSL::PKey::RSA.new(2048)
      @intermediate_certificate = issue_certificate(
        subject: "/CN=OpenAI Ruby mTLS test intermediate",
        key: intermediate_key,
        issuer: @root_certificate,
        issuer_key: root_key,
        ca: true,
        path_length: 0
      )
      @client_identities = client_names.to_h do |name|
        client_key = OpenSSL::PKey::RSA.new(2048)
        client_certificate = issue_certificate(
          subject: "/CN=OpenAI Ruby mTLS test client #{name}",
          key: client_key,
          issuer: @intermediate_certificate,
          issuer_key: intermediate_key,
          extended_key_usage: "clientAuth",
          subject_alt_name: "DNS:client-#{name}.x509.test"
        )
        [name, Identity.new(client_certificate, client_key)]
      end

      @server_identities = hostnames.to_h do |hostname|
        server_key = OpenSSL::PKey::RSA.new(2048)
        certificate = issue_certificate(
          subject: "/CN=#{hostname}",
          key: server_key,
          issuer: @intermediate_certificate,
          issuer_key: intermediate_key,
          extended_key_usage: "serverAuth",
          subject_alt_name: "DNS:#{hostname}"
        )
        [hostname, Identity.new(certificate, server_key)]
      end
    end

    def client_identity(name = :a) = @client_identities.fetch(name)

    def client_chain_pem(name = :a)
      [client_identity(name).certificate, intermediate_certificate].map(&:to_pem).join
    end

    def encrypted_client_key_pem(passphrase, name = :a)
      cipher = OpenSSL::Cipher.new("aes-256-cbc")
      client_identity(name).key.export(cipher, passphrase)
    end

    def server_identity(hostname) = @server_identities.fetch(hostname)

    def trust_store
      OpenSSL::X509::Store.new.tap { _1.add_cert(@root_certificate) }
    end

    def server_context(hostname)
      identity = server_identity(hostname)
      OpenSSL::SSL::SSLContext.new.tap do |context|
        context.cert = identity.certificate
        context.key = identity.key
        context.extra_chain_cert = [intermediate_certificate]
        context.cert_store = trust_store
        context.client_ca = [@root_certificate]
        context.verify_depth = 2
        context.verify_mode = OpenSSL::SSL::VERIFY_PEER | OpenSSL::SSL::VERIFY_FAIL_IF_NO_PEER_CERT
      end
    end

    private def issue_certificate(
      subject:,
      key:,
      issuer: nil,
      issuer_key: nil,
      ca: false,
      path_length: nil,
      extended_key_usage: nil,
      subject_alt_name: nil
    )
      @serial += 1
      certificate = OpenSSL::X509::Certificate.new
      certificate.version = 2
      certificate.serial = @serial
      certificate.subject = OpenSSL::X509::Name.parse(subject)
      certificate.issuer = issuer ? issuer.subject : certificate.subject
      certificate.public_key = key.public_key
      certificate.not_before = Time.now - 60
      certificate.not_after = Time.now + 3_600

      extensions = OpenSSL::X509::ExtensionFactory.new
      extensions.subject_certificate = certificate
      extensions.issuer_certificate = issuer || certificate
      constraints = ca ? "CA:TRUE" : "CA:FALSE"
      constraints = "#{constraints},pathlen:#{path_length}" unless path_length.nil?
      certificate.add_extension(extensions.create_extension("basicConstraints", constraints, true))
      certificate.add_extension(
        extensions.create_extension(
          "keyUsage",
          ca ? "keyCertSign,cRLSign" : "digitalSignature,keyEncipherment",
          true
        )
      )
      certificate.add_extension(extensions.create_extension("subjectKeyIdentifier", "hash"))
      certificate.add_extension(extensions.create_extension("authorityKeyIdentifier", "keyid:always"))
      unless extended_key_usage.nil?
        certificate.add_extension(extensions.create_extension("extendedKeyUsage", extended_key_usage))
      end

      unless subject_alt_name.nil?
        certificate.add_extension(extensions.create_extension("subjectAltName", subject_alt_name))
      end

      certificate.sign(issuer_key || key, OpenSSL::Digest.new("SHA256"))
      certificate
    end
  end

  class MTLSServer
    attr_reader :hostname, :local_port

    def initialize(
      hostname:,
      pki:,
      body: {ok: true},
      expected_connections: 1,
      certificate_hostname: hostname
    )
      @hostname = hostname
      @body = JSON.generate(body)
      @expected_connections = expected_connections
      @tcp_server = TCPServer.new("127.0.0.1", 0)
      @local_port = @tcp_server.local_address.ip_port
      context = pki.server_context(certificate_hostname)
      context.servername_cb = lambda do |(_socket, server_name)|
        @server_name = server_name
        nil
      end
      @ssl_server = OpenSSL::SSL::SSLServer.new(@tcp_server, context)
      @records = []
      @failure = nil
      @thread = Thread.new { serve }
      @thread.report_on_exception = false
    end

    def url(path = "/probe") = URI("https://#{hostname}#{path}")

    def finish
      unless @thread.join(SERVER_TIMEOUT)
        raise Timeout::Error, "mTLS test server did not finish"
      end

      raise @failure unless @failure.nil?

      @records.freeze
    end

    def close
      @tcp_server.close unless @tcp_server.closed?
      @thread.kill if @thread.alive?
      @thread.join
    end

    private def serve
      @expected_connections.times do
        @server_name = nil
        connection = @ssl_server.accept
        request_line, headers = read_request(connection)
        @records <<
          RequestRecord.new(
            @server_name,
            request_line,
            headers,
            connection.peer_cert,
            connection.peer_cert_chain,
            nil
          )
        connection.write(
          "HTTP/1.1 200 OK\r\nContent-Type: application/json\r\n" \
            "Content-Length: #{@body.bytesize}\r\nConnection: close\r\n\r\n#{@body}"
        )
      rescue OpenSSL::SSL::SSLError => e
        @records << RequestRecord.new(@server_name, nil, {}, nil, [], e)
      ensure
        connection&.close
      end

    rescue StandardError => e
      @failure = e
    end

    private def read_request(connection)
      request_line = connection.gets&.strip
      headers = {}
      bytes = request_line.to_s.bytesize
      loop do
        line = connection.gets
        break if line.nil? || line == "\r\n"

        bytes += line.bytesize
        raise IOError, "test request headers are too large" if bytes > MAX_HEADER_BYTES

        name, value = line.split(":", 2)
        headers[name.downcase] = value.to_s.strip
      end

      [request_line, headers.freeze]
    end
  end

  class ConnectProxy
    attr_reader :uri

    def initialize(authority_ports:, expected_connections:)
      @authority_ports = authority_ports.freeze
      @expected_connections = expected_connections
      @tcp_server = TCPServer.new("127.0.0.1", 0)
      port = @tcp_server.local_address.ip_port
      @uri = URI("http://proxy-user:proxy-pass@127.0.0.1:#{port}")
      @records = []
      @failure = nil
      @thread = Thread.new { serve }
      @thread.report_on_exception = false
    end

    def finish
      unless @thread.join(SERVER_TIMEOUT)
        raise Timeout::Error, "mTLS test proxy did not finish"
      end

      raise @failure unless @failure.nil?

      @records.freeze
    end

    def close
      @tcp_server.close unless @tcp_server.closed?
      @thread.kill if @thread.alive?
      @thread.join
    end

    private def serve
      @expected_connections.times do
        downstream = @tcp_server.accept
        request_line, headers = read_request(downstream)
        match = /\ACONNECT ([^ ]+) HTTP\/1\.1\z/.match(request_line)
        raise IOError, "test proxy expected a CONNECT request" if match.nil?

        authority = match[1]
        @records << ProxyRecord.new(authority, headers)
        local_port = @authority_ports[authority]
        if local_port.nil?
          downstream.write("HTTP/1.1 403 Forbidden\r\nConnection: close\r\n\r\n")
          next
        end

        upstream = TCPSocket.new("127.0.0.1", local_port)
        downstream.write("HTTP/1.1 200 Connection Established\r\n\r\n")
        relay(downstream, upstream)
      ensure
        downstream&.close
        upstream&.close
      end

    rescue StandardError => e
      @failure = e
    end

    private def read_request(connection)
      buffer = +""
      until buffer.include?("\r\n\r\n")
        buffer << connection.readpartial(1_024)
        raise IOError, "test proxy request headers are too large" if buffer.bytesize > MAX_HEADER_BYTES
      end

      lines = buffer.split("\r\n")
      request_line = lines.shift
      headers = lines.take_while { !_1.empty? }.to_h do |line|
        name, value = line.split(":", 2)
        [name.downcase, value.to_s.strip]
      end

      [request_line, headers.freeze]
    end

    private def relay(left, right)
      threads = [
        Thread.new { copy_stream(left, right) },
        Thread.new { copy_stream(right, left) }
      ]
      threads.each(&:join)
    ensure
      threads&.each { _1.kill if _1.alive? }
      threads&.each(&:join)
    end

    private def copy_stream(source, destination)
      IO.copy_stream(source, destination)
    rescue IOError, SystemCallError
      nil
    ensure
      begin
        destination.close_write
      rescue IOError, SystemCallError
        nil
      end
    end
  end

  PROXY_ENV_KEYS = %w[
    http_proxy
    https_proxy
    all_proxy
    no_proxy
    HTTP_PROXY
    HTTPS_PROXY
    ALL_PROXY
    NO_PROXY
  ].freeze

  def self.with_proxy_environment(proxy_uri)
    previous = PROXY_ENV_KEYS.to_h { [_1, ENV[_1]] }
    PROXY_ENV_KEYS.each { ENV.delete(_1) }
    ENV["http_proxy"] = proxy_uri.to_s
    ENV["https_proxy"] = proxy_uri.to_s
    yield
  ensure
    previous&.each { |name, value| value.nil? ? ENV.delete(name) : ENV[name] = value }
  end
end
