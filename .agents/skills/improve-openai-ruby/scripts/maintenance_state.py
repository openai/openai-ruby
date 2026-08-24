"""Coordinate non-sensitive SDK maintenance tasks across linked worktrees."""

from __future__ import annotations

import argparse
import contextlib
import fcntl
import hashlib
import json
import os
import subprocess
import sys
import tempfile
import time
import uuid
from pathlib import Path, PurePosixPath
from typing import Any, Iterator


LABEL = "codex-maintenance"
SCHEMA_VERSION = 1


class CoordinationError(Exception):
    """A reservation or publication could not be completed safely."""


def state_directory(repository: str, override: str | None) -> Path:
    if override:
        return Path(override).expanduser()

    cache = Path(os.environ.get("XDG_CACHE_HOME", Path.home() / ".cache"))
    namespace = hashlib.sha256(repository.encode()).hexdigest()[:16]
    return cache / "openai-ruby-maintenance" / namespace


@contextlib.contextmanager
def locked_state(directory: Path) -> Iterator[dict[str, Any]]:
    directory.mkdir(mode=0o700, parents=True, exist_ok=True)
    if directory.is_symlink():
        raise CoordinationError("maintenance state directory must not be a symlink")
    directory.chmod(0o700)

    flags = os.O_CREAT | os.O_RDWR | getattr(os, "O_NOFOLLOW", 0)
    try:
        descriptor = os.open(directory / "state.lock", flags, 0o600)
    except OSError as error:
        raise CoordinationError(
            f"cannot safely open maintenance lock: {error}"
        ) from error

    try:
        os.fchmod(descriptor, 0o600)
        fcntl.flock(descriptor, fcntl.LOCK_EX)
        path = directory / "state.json"
        if path.is_symlink():
            raise CoordinationError("maintenance ledger must not be a symlink")
        if path.exists():
            try:
                state = json.loads(path.read_text())
            except (OSError, json.JSONDecodeError) as error:
                raise CoordinationError(
                    "maintenance ledger is unreadable or malformed"
                ) from error
        else:
            state = {"schema_version": SCHEMA_VERSION, "reservations": []}

        if (
            not isinstance(state, dict)
            or state.get("schema_version") != SCHEMA_VERSION
            or not isinstance(state.get("reservations"), list)
        ):
            raise CoordinationError("maintenance ledger has an unsupported schema")

        yield state

        with tempfile.NamedTemporaryFile("w", dir=directory, delete=False) as temporary:
            os.fchmod(temporary.fileno(), 0o600)
            json.dump(state, temporary, indent=2, sort_keys=True)
            temporary.write("\n")
            temporary.flush()
            os.fsync(temporary.fileno())
        os.replace(temporary.name, path)
        directory_descriptor = os.open(
            directory, os.O_RDONLY | getattr(os, "O_DIRECTORY", 0)
        )
        try:
            os.fsync(directory_descriptor)
        finally:
            os.close(directory_descriptor)
    finally:
        fcntl.flock(descriptor, fcntl.LOCK_UN)
        os.close(descriptor)


def run_gh(executable: str, *arguments: str) -> str:
    result = subprocess.run(
        [executable, *arguments],
        check=False,
        capture_output=True,
        text=True,
    )
    if result.returncode:
        raise CoordinationError(result.stderr.strip() or "GitHub CLI command failed")
    return result.stdout


def open_pull_request_count(arguments: argparse.Namespace) -> int:
    output = run_gh(
        arguments.gh,
        "pr",
        "list",
        "--repo",
        arguments.repo,
        "--state",
        "open",
        "--label",
        LABEL,
        "--limit",
        "100",
        "--json",
        "number",
    )
    try:
        pull_requests = json.loads(output)
    except json.JSONDecodeError as error:
        raise CoordinationError(
            "GitHub returned an invalid maintenance PR count"
        ) from error
    if not isinstance(pull_requests, list):
        raise CoordinationError("GitHub returned an invalid maintenance PR count")
    return len(pull_requests)


def normalize_paths(paths: list[str]) -> list[str]:
    normalized = []
    for raw in paths:
        path = PurePosixPath(raw)
        if path.is_absolute() or ".." in path.parts or not path.parts:
            raise CoordinationError(
                "reserved paths must be safe, repository-relative paths"
            )
        normalized.append(path.as_posix())
    return sorted(set(normalized))


def paths_overlap(first: list[str], second: list[str]) -> bool:
    return any(
        left == right or left.startswith(right + "/") or right.startswith(left + "/")
        for left in first
        for right in second
    )


def reservation_for(state: dict[str, Any], identifier: str) -> dict[str, Any]:
    for reservation in state["reservations"]:
        if reservation["reservation_id"] == identifier:
            return reservation
    raise CoordinationError("maintenance reservation does not exist")


def reserve(arguments: argparse.Namespace, state: dict[str, Any]) -> dict[str, Any]:
    paths = normalize_paths(arguments.path)
    finding_key = hashlib.sha256(arguments.finding_key.encode()).hexdigest()
    for existing in state["reservations"]:
        if existing["finding_key"] == finding_key:
            raise CoordinationError(
                "finding was already dispatched to an outstanding task"
            )
        if paths_overlap(paths, existing["paths"]):
            raise CoordinationError(
                "reserved paths overlap an outstanding dispatched task"
            )

    open_count = open_pull_request_count(arguments)
    unpublished = sum(
        not reservation.get("pr_url") for reservation in state["reservations"]
    )
    if open_count + unpublished >= arguments.limit:
        raise CoordinationError("maintenance PR capacity is already fully reserved")

    reservation = {
        "reservation_id": uuid.uuid4().hex,
        "finding_key": finding_key,
        "paths": paths,
        "task_id": None,
        "pr_url": None,
        "updated_at": time.time(),
    }
    state["reservations"].append(reservation)
    return reservation


def attach(arguments: argparse.Namespace, state: dict[str, Any]) -> dict[str, Any]:
    reservation = reservation_for(state, arguments.reservation_id)
    if reservation["task_id"] and reservation["task_id"] != arguments.task_id:
        raise CoordinationError(
            "maintenance reservation already belongs to another task"
        )
    if any(
        other is not reservation and other.get("task_id") == arguments.task_id
        for other in state["reservations"]
    ):
        raise CoordinationError("maintenance task already owns another reservation")
    reservation["task_id"] = arguments.task_id
    reservation["updated_at"] = time.time()
    return reservation


def publish(arguments: argparse.Namespace, state: dict[str, Any]) -> dict[str, Any]:
    reservation = reservation_for(state, arguments.reservation_id)
    if not reservation.get("task_id"):
        raise CoordinationError("publication requires an attached saved-project task")
    if reservation.get("pr_url"):
        raise CoordinationError(
            "maintenance reservation already has a public pull request"
        )
    if open_pull_request_count(arguments) >= arguments.limit:
        raise CoordinationError(
            "maintenance PR capacity was consumed before publication"
        )

    output = run_gh(
        arguments.gh,
        "pr",
        "create",
        "--repo",
        arguments.repo,
        "--base",
        arguments.base,
        "--head",
        arguments.head,
        "--title",
        arguments.title,
        "--body-file",
        arguments.body_file,
        "--draft",
        "--label",
        LABEL,
    )
    urls = [line.strip() for line in output.splitlines() if line.startswith("https://")]
    if len(urls) != 1:
        raise CoordinationError(
            "GitHub did not return exactly one created pull-request URL"
        )

    url = urls[0]
    try:
        metadata = json.loads(
            run_gh(arguments.gh, "pr", "view", url, "--json", "labels")
        )
        labels = {label["name"] for label in metadata["labels"]}
    except (CoordinationError, json.JSONDecodeError, KeyError, TypeError) as error:
        run_gh(arguments.gh, "pr", "close", url)
        raise CoordinationError(
            "created maintenance pull request could not be verified"
        ) from error
    if LABEL not in labels:
        run_gh(arguments.gh, "pr", "close", url)
        raise CoordinationError(
            "created maintenance pull request was missing its required label"
        )

    reservation["pr_url"] = url
    reservation["updated_at"] = time.time()
    return reservation


def reconcile(arguments: argparse.Namespace, state: dict[str, Any]) -> dict[str, Any]:
    active = set(arguments.active_task)
    terminal = set(arguments.terminal_task)
    if active & terminal:
        raise CoordinationError("a task cannot be both active and terminal")

    outstanding = []
    for reservation in state["reservations"]:
        task_id = reservation.get("task_id")
        if task_id in terminal:
            continue
        if task_id in active:
            reservation["updated_at"] = time.time()
        outstanding.append(reservation)
    state["reservations"] = outstanding
    return {"outstanding": outstanding}


def finish(arguments: argparse.Namespace, state: dict[str, Any]) -> dict[str, Any]:
    reservation = reservation_for(state, arguments.reservation_id)
    if arguments.command == "abandon" and reservation.get("task_id"):
        raise CoordinationError(
            "an attached task must be confirmed terminal before release"
        )
    state["reservations"].remove(reservation)
    return {"released": reservation["reservation_id"]}


def parser() -> argparse.ArgumentParser:
    command = argparse.ArgumentParser(description=__doc__)
    command.add_argument("--state-dir")
    command.add_argument("--repo", default="openai/openai-ruby")
    command.add_argument("--gh", default="gh")
    command.add_argument("--limit", type=int, default=5)
    subcommands = command.add_subparsers(dest="command", required=True)

    reserve_command = subcommands.add_parser("reserve")
    reserve_command.add_argument("--finding-key", required=True)
    reserve_command.add_argument("--path", action="append", required=True)

    attach_command = subcommands.add_parser("attach")
    attach_command.add_argument("--reservation-id", required=True)
    attach_command.add_argument("--task-id", required=True)

    publish_command = subcommands.add_parser("publish")
    publish_command.add_argument("--reservation-id", required=True)
    publish_command.add_argument("--base", default="main")
    publish_command.add_argument("--head", required=True)
    publish_command.add_argument("--title", required=True)
    publish_command.add_argument("--body-file", required=True)

    reconcile_command = subcommands.add_parser("reconcile")
    reconcile_command.add_argument("--active-task", action="append", default=[])
    reconcile_command.add_argument("--terminal-task", action="append", default=[])

    for name in ("finish", "abandon"):
        release = subcommands.add_parser(name)
        release.add_argument("--reservation-id", required=True)

    return command


def main() -> int:
    arguments = parser().parse_args()
    if not 1 <= arguments.limit <= 5:
        print(
            "maintenance PR capacity limit must be positive and at most five",
            file=sys.stderr,
        )
        return 1

    handlers = {
        "reserve": reserve,
        "attach": attach,
        "publish": publish,
        "reconcile": reconcile,
        "finish": finish,
        "abandon": finish,
    }
    try:
        with locked_state(
            state_directory(arguments.repo, arguments.state_dir)
        ) as state:
            result = handlers[arguments.command](arguments, state)
            print(json.dumps(result, sort_keys=True))
    except (CoordinationError, OSError) as error:
        print(str(error), file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
