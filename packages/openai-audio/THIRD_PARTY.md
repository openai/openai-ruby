# Native dependencies

The worker links PortAudio and libsamplerate. Neither is downloaded or installed
by the SDK or by loading this companion. Source builds use explicitly installed
libraries; platform release builds must record exact source revisions, license
notices, compiler and build flags, and binary checksums.

Development validation used:

- PortAudio v19.7.0, commit `147dd722548358763a8b649b3e4b41dfffbcfbb6`.
  [Source and MIT-style license](https://github.com/PortAudio/portaudio/tree/147dd722548358763a8b649b3e4b41dfffbcfbb6).
- libsamplerate 0.2.2, BSD 2-Clause license.
  [Source and license](https://github.com/libsndfile/libsamplerate/tree/0.2.2).

Redistributions must include both upstream license texts. No prebuilt native
binary is committed here. A source-only checkout is not a working binary gem.
