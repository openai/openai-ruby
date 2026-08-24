"""Regression coverage for public maintenance reservations and task ownership."""

from __future__ import annotations

import concurrent.futures
import json
import os
import stat
import subprocess
import sys
import tempfile
import textwrap
import unittest
from pathlib import Path


SCRIPT = Path(__file__).with_name("maintenance_state.py")


class MaintenanceStateTests(unittest.TestCase):
    def setUp(self) -> None:
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        self.state_directory = self.root / "state"
        self.github_state = self.root / "github.json"
        self.github_state.write_text(json.dumps({"count": 4, "events": []}))
        self.github = self.root / "gh"
        self.github.write_text(
            "#!"
            + sys.executable
            + "\n"
            + textwrap.dedent(
                """\
                import json
                import os
                import sys
                import time
                from pathlib import Path

                state_path = Path(os.environ["MAINTENANCE_FAKE_GITHUB_STATE"])
                arguments = sys.argv[1:]
                state = json.loads(state_path.read_text())

                if arguments[:2] == ["pr", "list"]:
                    print(json.dumps([{"number": number} for number in range(state["count"])]))
                elif arguments[:2] == ["pr", "create"]:
                    if "--draft" not in arguments or "--label" not in arguments:
                        raise SystemExit("maintenance drafts require their label at creation")
                    state["events"].append(["start", time.time()])
                    state_path.write_text(json.dumps(state))
                    time.sleep(0.12)
                    state = json.loads(state_path.read_text())
                    state["count"] += 1
                    state["events"].append(["finish", time.time()])
                    state_path.write_text(json.dumps(state))
                    print(f"https://github.com/openai/openai-ruby/pull/{state['count']}")
                elif arguments[:2] == ["pr", "view"]:
                    if state.get("fail_view"):
                        raise SystemExit("label verification unavailable")
                    labels = state.get("labels", ["codex-maintenance"])
                    print(json.dumps({"labels": [{"name": label} for label in labels]}))
                elif arguments[:2] == ["pr", "close"]:
                    state["count"] -= 1
                    state_path.write_text(json.dumps(state))
                else:
                    raise SystemExit(f"unexpected gh arguments: {arguments}")
                """
            )
        )
        self.github.chmod(0o700)

    def run_command(self, *arguments: str) -> subprocess.CompletedProcess[str]:
        return subprocess.run(
            [
                sys.executable,
                "-B",
                str(SCRIPT),
                "--state-dir",
                str(self.state_directory),
                "--gh",
                str(self.github),
                *arguments,
            ],
            check=False,
            capture_output=True,
            text=True,
            env={**os.environ, "MAINTENANCE_FAKE_GITHUB_STATE": str(self.github_state)},
        )

    def reserve(self, finding: str, *paths: str) -> dict[str, object]:
        arguments = ["reserve", "--finding-key", finding]
        for path in paths:
            arguments.extend(["--path", path])
        result = self.run_command(*arguments)
        self.assertEqual(result.returncode, 0, result.stderr)
        return json.loads(result.stdout)

    def update_open_count(self, count: int) -> None:
        state = json.loads(self.github_state.read_text())
        state["count"] = count
        self.github_state.write_text(json.dumps(state))

    def attach(self, reservation: dict[str, object], task_id: str) -> None:
        result = self.run_command(
            "attach",
            "--reservation-id",
            str(reservation["reservation_id"]),
            "--task-id",
            task_id,
        )
        self.assertEqual(result.returncode, 0, result.stderr)

    def test_concurrent_reservations_cannot_claim_one_remaining_slot_twice(
        self,
    ) -> None:
        def reserve_candidate(number: int) -> subprocess.CompletedProcess[str]:
            return self.run_command(
                "reserve",
                "--finding-key",
                f"finding-{number}",
                "--path",
                f"lib/openai/feature_{number}.rb",
            )

        with concurrent.futures.ThreadPoolExecutor(max_workers=8) as workers:
            results = list(workers.map(reserve_candidate, range(8)))

        successes = [result for result in results if result.returncode == 0]
        self.assertEqual(len(successes), 1, [result.stderr for result in results])
        self.assertTrue(
            all(
                "capacity" in result.stderr.lower()
                for result in results
                if result.returncode
            ),
            [result.stderr for result in results],
        )

    def test_concurrent_publication_holds_lock_through_creation_and_labeling(
        self,
    ) -> None:
        self.update_open_count(3)
        first = self.reserve("finding-first", "lib/openai/first.rb")
        second = self.reserve("finding-second", "lib/openai/second.rb")
        self.attach(first, "first-task")
        self.attach(second, "second-task")
        body = self.root / "body.md"
        body.write_text("Customer-impacting, non-sensitive maintenance fix.\n")

        def publish(reservation: dict[str, object]) -> subprocess.CompletedProcess[str]:
            return self.run_command(
                "publish",
                "--reservation-id",
                str(reservation["reservation_id"]),
                "--head",
                f"codex/{reservation['finding_key']}",
                "--title",
                "fix: preserve customer behavior",
                "--body-file",
                str(body),
            )

        with concurrent.futures.ThreadPoolExecutor(max_workers=2) as workers:
            results = list(workers.map(publish, [first, second]))

        self.assertTrue(all(result.returncode == 0 for result in results), results)
        state = json.loads(self.github_state.read_text())
        self.assertEqual(state["count"], 5)
        self.assertEqual(
            [event[0] for event in state["events"]], ["start", "finish"] * 2
        )

    def test_publication_recounts_capacity_under_the_same_lock(self) -> None:
        reservation = self.reserve("late-capacity", "lib/openai/client.rb")
        self.attach(reservation, "late-capacity-task")
        self.update_open_count(5)
        body = self.root / "body.md"
        body.write_text("Verified maintenance fix.\n")

        result = self.run_command(
            "publish",
            "--reservation-id",
            str(reservation["reservation_id"]),
            "--head",
            "codex/late-capacity",
            "--title",
            "fix: preserve customer behavior",
            "--body-file",
            str(body),
        )

        self.assertNotEqual(result.returncode, 0)
        self.assertIn("capacity", result.stderr)
        self.assertEqual(json.loads(self.github_state.read_text())["events"], [])

    def test_unlabeled_publication_closes_only_the_created_draft(self) -> None:
        reservation = self.reserve("unlabeled-finding", "lib/openai/client.rb")
        self.attach(reservation, "unlabeled-task")
        state = json.loads(self.github_state.read_text())
        state["labels"] = []
        self.github_state.write_text(json.dumps(state))
        body = self.root / "body.md"
        body.write_text("Verified maintenance fix.\n")

        result = self.run_command(
            "publish",
            "--reservation-id",
            str(reservation["reservation_id"]),
            "--head",
            "codex/unlabeled-finding",
            "--title",
            "fix: preserve customer behavior",
            "--body-file",
            str(body),
        )

        self.assertNotEqual(result.returncode, 0)
        self.assertIn("missing its required label", result.stderr)
        self.assertEqual(json.loads(self.github_state.read_text())["count"], 4)

    def test_unverifiable_publication_closes_only_the_created_draft(self) -> None:
        reservation = self.reserve("unverified-finding", "lib/openai/client.rb")
        self.attach(reservation, "unverified-task")
        state = json.loads(self.github_state.read_text())
        state["fail_view"] = True
        self.github_state.write_text(json.dumps(state))
        body = self.root / "body.md"
        body.write_text("Verified maintenance fix.\n")

        result = self.run_command(
            "publish",
            "--reservation-id",
            str(reservation["reservation_id"]),
            "--head",
            "codex/unverified-finding",
            "--title",
            "fix: preserve customer behavior",
            "--body-file",
            str(body),
        )

        self.assertNotEqual(result.returncode, 0)
        self.assertIn("could not be verified", result.stderr)
        self.assertEqual(json.loads(self.github_state.read_text())["count"], 4)

    def test_publication_requires_an_attached_saved_project_task(self) -> None:
        reservation = self.reserve("unattached-finding", "lib/openai/client.rb")
        body = self.root / "body.md"
        body.write_text("Verified maintenance fix.\n")

        result = self.run_command(
            "publish",
            "--reservation-id",
            str(reservation["reservation_id"]),
            "--head",
            "codex/unattached-finding",
            "--title",
            "fix: preserve customer behavior",
            "--body-file",
            str(body),
        )

        self.assertNotEqual(result.returncode, 0)
        self.assertIn("attached", result.stderr)
        self.assertEqual(json.loads(self.github_state.read_text())["events"], [])

    def test_new_scan_rejects_existing_finding_before_its_task_opens_a_pr(self) -> None:
        reservation = self.reserve("stable-finding", "lib/openai/internal/stream.rb")
        attached = self.run_command(
            "attach",
            "--reservation-id",
            str(reservation["reservation_id"]),
            "--task-id",
            "saved-project-task-123",
        )
        self.assertEqual(attached.returncode, 0, attached.stderr)

        duplicate = self.run_command(
            "reserve",
            "--finding-key",
            "stable-finding",
            "--path",
            "lib/openai/internal/another_path.rb",
        )

        self.assertNotEqual(duplicate.returncode, 0)
        self.assertIn("already dispatched", duplicate.stderr)

    def test_new_scan_rejects_overlapping_paths_owned_by_an_active_task(self) -> None:
        self.update_open_count(3)
        self.reserve("stream-root-cause", "lib/openai/internal/stream.rb")

        duplicate = self.run_command(
            "reserve",
            "--finding-key",
            "different-root-cause",
            "--path",
            "lib/openai/internal/stream.rb",
        )

        self.assertNotEqual(duplicate.returncode, 0)
        self.assertIn("overlap", duplicate.stderr)

    def test_new_scan_rejects_parent_directory_path_overlap(self) -> None:
        self.update_open_count(3)
        self.reserve("stream-directory", "lib/openai/internal")

        duplicate = self.run_command(
            "reserve",
            "--finding-key",
            "nested-stream-file",
            "--path",
            "lib/openai/internal/stream.rb",
        )

        self.assertNotEqual(duplicate.returncode, 0)
        self.assertIn("overlap", duplicate.stderr)

    def test_reconcile_preserves_unconfirmed_active_tasks_across_scans(self) -> None:
        reservation = self.reserve("active-finding", "lib/openai/client.rb")
        attached = self.run_command(
            "attach",
            "--reservation-id",
            str(reservation["reservation_id"]),
            "--task-id",
            "active-task",
        )
        self.assertEqual(attached.returncode, 0, attached.stderr)

        reconciled = self.run_command("reconcile")
        self.assertEqual(reconciled.returncode, 0, reconciled.stderr)
        self.assertEqual(
            json.loads(reconciled.stdout)["outstanding"][0]["task_id"], "active-task"
        )

        duplicate = self.run_command(
            "reserve",
            "--finding-key",
            "active-finding",
            "--path",
            "lib/openai/other.rb",
        )
        self.assertNotEqual(duplicate.returncode, 0)

    def test_only_confirmed_terminal_task_releases_capacity_and_paths(self) -> None:
        first = self.reserve("completed-finding", "lib/openai/client.rb")
        self.assertEqual(
            self.run_command(
                "attach",
                "--reservation-id",
                str(first["reservation_id"]),
                "--task-id",
                "finished-task",
            ).returncode,
            0,
        )

        reconciled = self.run_command("reconcile", "--terminal-task", "finished-task")
        self.assertEqual(reconciled.returncode, 0, reconciled.stderr)
        self.assertEqual(json.loads(reconciled.stdout)["outstanding"], [])

        next_reservation = self.reserve("new-finding", "lib/openai/client.rb")
        self.assertNotEqual(first["reservation_id"], next_reservation["reservation_id"])

    def test_abandon_cannot_discard_an_attached_active_task(self) -> None:
        reservation = self.reserve("active-finding", "lib/openai/client.rb")
        self.attach(reservation, "active-task")

        abandoned = self.run_command(
            "abandon", "--reservation-id", str(reservation["reservation_id"])
        )

        self.assertNotEqual(abandoned.returncode, 0)
        self.assertIn("confirmed terminal", abandoned.stderr)

    def test_capacity_limit_cannot_exceed_repository_cap(self) -> None:
        result = self.run_command(
            "--limit",
            "6",
            "reserve",
            "--finding-key",
            "over-cap",
            "--path",
            "lib/openai/client.rb",
        )

        self.assertNotEqual(result.returncode, 0)
        self.assertIn("at most five", result.stderr)

    def test_malformed_ledger_fails_closed_without_calling_github(self) -> None:
        self.state_directory.mkdir(mode=0o700)
        (self.state_directory / "state.json").write_text("not-json")

        result = self.run_command(
            "reserve",
            "--finding-key",
            "malformed-ledger",
            "--path",
            "lib/openai/client.rb",
        )

        self.assertNotEqual(result.returncode, 0)
        self.assertIn("malformed", result.stderr)
        self.assertEqual(json.loads(self.github_state.read_text())["events"], [])

    def test_symlinked_ledger_fails_closed_without_following_its_target(self) -> None:
        self.state_directory.mkdir(mode=0o700)
        target = self.root / "unrelated.json"
        target.write_text("must remain unchanged")
        (self.state_directory / "state.json").symlink_to(target)

        result = self.run_command(
            "reserve",
            "--finding-key",
            "symlinked-ledger",
            "--path",
            "lib/openai/client.rb",
        )

        self.assertNotEqual(result.returncode, 0)
        self.assertIn("must not be a symlink", result.stderr)
        self.assertEqual(target.read_text(), "must remain unchanged")

    def test_shell_metacharacters_remain_plain_subprocess_arguments(self) -> None:
        marker = self.root / "unexpected-command-execution"
        finding_key = f"finding; touch {marker}"
        reservation = self.reserve(finding_key, "lib/openai/client.rb")

        self.assertFalse(marker.exists())
        self.assertNotIn(finding_key, (self.state_directory / "state.json").read_text())
        self.assertEqual(len(str(reservation["finding_key"])), 64)

    def test_rejects_parent_or_absolute_ledger_paths(self) -> None:
        for path in ("../credential.json", str(self.root / "credential.json")):
            with self.subTest(path=path):
                result = self.run_command(
                    "reserve",
                    "--finding-key",
                    "invalid-path",
                    "--path",
                    path,
                )
                self.assertNotEqual(result.returncode, 0)
                self.assertIn("repository-relative", result.stderr)

    def test_shared_ledger_is_owner_only_and_does_not_store_raw_finding_keys(
        self,
    ) -> None:
        finding_key = "customer-visible-streaming-root-cause"
        self.reserve(finding_key, "lib/openai/internal/stream.rb")

        ledger = self.state_directory / "state.json"
        lock = self.state_directory / "state.lock"

        self.assertEqual(stat.S_IMODE(self.state_directory.stat().st_mode), 0o700)
        self.assertEqual(stat.S_IMODE(ledger.stat().st_mode), 0o600)
        self.assertEqual(stat.S_IMODE(lock.stat().st_mode), 0o600)
        self.assertNotIn(finding_key, ledger.read_text())


if __name__ == "__main__":
    unittest.main()
