"""Regression coverage for public maintenance reservations and task ownership."""

from __future__ import annotations

import concurrent.futures
import json
import os
import shutil
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
        self.github_state.write_text(
            json.dumps({"count": 4, "events": [], "pull_requests": []})
        )
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
                    if "--head" in arguments:
                        if state.get("fail_lookup"):
                            raise SystemExit("existing draft lookup unavailable")
                        print(json.dumps(state.get("recovery_candidates", state["pull_requests"])))
                    else:
                        print(json.dumps([{"number": number} for number in range(state["count"])]))
                elif arguments[:2] == ["pr", "create"]:
                    if "--draft" not in arguments or "--label" not in arguments:
                        raise SystemExit("maintenance drafts require their label at creation")
                    if state.get("create_failure") == "before":
                        raise SystemExit("connection failed before draft creation")
                    state["events"].append(["start", time.time()])
                    state_path.write_text(json.dumps(state))
                    time.sleep(0.12)
                    state = json.loads(state_path.read_text())
                    state["count"] += 1
                    state["events"].append(["finish", time.time()])
                    url = f"https://github.com/openai/openai-ruby/pull/{state['count']}"
                    state["pull_requests"].append({
                        "url": url,
                        "isDraft": state.get("created_is_draft", True),
                        "baseRefName": state.get("created_base", arguments[arguments.index("--base") + 1]),
                        "headRefName": state.get("created_head", arguments[arguments.index("--head") + 1]),
                        "labels": [{"name": label} for label in state.get("labels", ["codex-maintenance"])],
                    })
                    state_path.write_text(json.dumps(state))
                    if state.get("create_failure") == "after":
                        raise SystemExit("connection lost after remote draft creation")
                    if not state.get("lose_create_url"):
                        print(url)
                elif arguments[:2] == ["pr", "view"]:
                    if state.get("fail_view"):
                        raise SystemExit("label verification unavailable")
                    matches = [pr for pr in state["pull_requests"] if pr["url"] == arguments[2]]
                    if len(matches) != 1:
                        raise SystemExit("expected exactly one created draft")
                    print(json.dumps(matches[0]))
                elif arguments[:2] == ["pr", "close"]:
                    state["count"] -= 1
                    state["pull_requests"] = [
                        pr for pr in state["pull_requests"] if pr["url"] != arguments[2]
                    ]
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

    def publish_reservation(
        self, reservation: dict[str, object], head: str = "codex/recover-draft"
    ) -> subprocess.CompletedProcess[str]:
        body = self.root / "publication-body.md"
        body.write_text("Verified non-sensitive maintenance fix.\n")
        return self.run_command(
            "publish",
            "--reservation-id",
            str(reservation["reservation_id"]),
            "--base",
            "main",
            "--head",
            head,
            "--title",
            "fix: preserve customer behavior",
            "--body-file",
            str(body),
        )

    def update_github_state(self, **changes: object) -> None:
        state = json.loads(self.github_state.read_text())
        state.update(changes)
        self.github_state.write_text(json.dumps(state))

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

    def test_ambiguous_creation_recovers_unique_labeled_draft(self) -> None:
        reservation = self.reserve("ambiguous-create", "lib/openai/client.rb")
        self.attach(reservation, "ambiguous-task")
        self.update_github_state(create_failure="after")

        result = self.publish_reservation(reservation)

        self.assertEqual(result.returncode, 0, result.stderr)
        published = json.loads(result.stdout)
        self.assertEqual(
            published["pr_url"], "https://github.com/openai/openai-ruby/pull/5"
        )
        self.assertEqual(json.loads(self.github_state.read_text())["count"], 5)
        records = json.loads((self.state_directory / "state.json").read_text())
        self.assertEqual(records["reservations"][0]["pr_url"], published["pr_url"])

    def test_lost_create_url_recovers_unique_labeled_draft(self) -> None:
        reservation = self.reserve("lost-create-url", "lib/openai/client.rb")
        self.attach(reservation, "lost-url-task")
        self.update_github_state(lose_create_url=True)

        result = self.publish_reservation(reservation)

        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(
            json.loads(result.stdout)["pr_url"],
            "https://github.com/openai/openai-ruby/pull/5",
        )

    def test_retry_recovers_existing_draft_even_when_capacity_is_full(self) -> None:
        reservation = self.reserve("retry-existing-draft", "lib/openai/client.rb")
        self.attach(reservation, "retry-task")
        self.update_github_state(create_failure="after", fail_lookup=True)

        first_attempt = self.publish_reservation(reservation)
        self.assertNotEqual(first_attempt.returncode, 0)
        state = json.loads(self.github_state.read_text())
        self.assertEqual(state["count"], 5)
        self.assertEqual(len(state["events"]), 2)

        self.update_github_state(fail_lookup=False)
        recovered = self.publish_reservation(reservation)

        self.assertEqual(recovered.returncode, 0, recovered.stderr)
        self.assertEqual(
            json.loads(recovered.stdout)["pr_url"],
            "https://github.com/openai/openai-ruby/pull/5",
        )
        self.assertEqual(len(json.loads(self.github_state.read_text())["events"]), 2)

    def test_ambiguous_creation_with_no_candidate_fails_closed(self) -> None:
        reservation = self.reserve("missing-created-draft", "lib/openai/client.rb")
        self.attach(reservation, "missing-draft-task")
        self.update_github_state(create_failure="before")

        result = self.publish_reservation(reservation)

        self.assertNotEqual(result.returncode, 0)
        self.assertIn("exactly one", result.stderr)
        state = json.loads(self.github_state.read_text())
        self.assertEqual(state["count"], 4)
        self.assertEqual(state["pull_requests"], [])

    def test_ambiguous_creation_with_multiple_candidates_does_not_close_either(
        self,
    ) -> None:
        reservation = self.reserve("multiple-created-drafts", "lib/openai/client.rb")
        self.attach(reservation, "multiple-draft-task")
        candidates = [
            {
                "url": f"https://github.com/openai/openai-ruby/pull/{number}",
                "isDraft": True,
                "baseRefName": "main",
                "headRefName": "codex/recover-draft",
                "labels": [{"name": "codex-maintenance"}],
            }
            for number in (5, 6)
        ]
        self.update_github_state(create_failure="after", recovery_candidates=candidates)

        result = self.publish_reservation(reservation)

        self.assertNotEqual(result.returncode, 0)
        self.assertIn("exactly one", result.stderr)
        self.assertEqual(json.loads(self.github_state.read_text())["count"], 5)

    def test_ambiguous_creation_rejects_mismatched_base_head_and_non_draft(
        self,
    ) -> None:
        for mutation in (
            {"created_base": "another-base"},
            {"created_head": "codex/another-task"},
            {"created_is_draft": False},
        ):
            with self.subTest(mutation=mutation):
                with tempfile.TemporaryDirectory() as directory:
                    previous_state = self.state_directory
                    self.state_directory = Path(directory) / "state"
                    self.github_state.write_text(
                        json.dumps(
                            {
                                "count": 4,
                                "events": [],
                                "pull_requests": [],
                                "create_failure": "after",
                                **mutation,
                            }
                        )
                    )
                    reservation = self.reserve(
                        "mismatched-draft", "lib/openai/client.rb"
                    )
                    self.attach(reservation, "mismatch-task")

                    result = self.publish_reservation(reservation)

                    self.assertNotEqual(result.returncode, 0)
                    self.assertIn("match the reserved", result.stderr)
                    self.assertEqual(
                        json.loads(self.github_state.read_text())["count"], 5
                    )
                    self.state_directory = previous_state

    def test_recovered_unlabeled_draft_is_not_closed_without_proven_ownership(
        self,
    ) -> None:
        reservation = self.reserve("unlabeled-recovery", "lib/openai/client.rb")
        self.attach(reservation, "unlabeled-recovery-task")
        self.update_github_state(create_failure="after", labels=[])

        result = self.publish_reservation(reservation)

        self.assertNotEqual(result.returncode, 0)
        self.assertIn("required label", result.stderr)
        self.assertEqual(json.loads(self.github_state.read_text())["count"], 5)

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

    def test_cache_cleanup_cannot_remove_persistent_active_reservations(self) -> None:
        persistent_state = self.root / "persistent-state"
        expendable_cache = self.root / "expendable-cache"
        expendable_cache.mkdir()
        environment = {
            **os.environ,
            "MAINTENANCE_FAKE_GITHUB_STATE": str(self.github_state),
            "XDG_STATE_HOME": str(persistent_state),
            "XDG_CACHE_HOME": str(expendable_cache),
        }

        def run_default(*arguments: str) -> subprocess.CompletedProcess[str]:
            return subprocess.run(
                [
                    sys.executable,
                    "-B",
                    str(SCRIPT),
                    "--gh",
                    str(self.github),
                    *arguments,
                ],
                check=False,
                capture_output=True,
                text=True,
                env=environment,
            )

        created = run_default(
            "reserve",
            "--finding-key",
            "persistent-active-task",
            "--path",
            "lib/openai/internal/stream.rb",
        )
        self.assertEqual(created.returncode, 0, created.stderr)
        reservation = json.loads(created.stdout)
        attached = run_default(
            "attach",
            "--reservation-id",
            reservation["reservation_id"],
            "--task-id",
            "still-active-task",
        )
        self.assertEqual(attached.returncode, 0, attached.stderr)

        shutil.rmtree(expendable_cache)
        reconciled = run_default("reconcile")

        self.assertEqual(reconciled.returncode, 0, reconciled.stderr)
        self.assertEqual(
            json.loads(reconciled.stdout)["outstanding"][0]["task_id"],
            "still-active-task",
        )
        ledgers = list(persistent_state.rglob("state.json"))
        self.assertEqual(len(ledgers), 1)

    def test_default_state_fallback_uses_local_state_instead_of_cache(self) -> None:
        environment = {
            key: value for key, value in os.environ.items() if key != "XDG_STATE_HOME"
        }
        environment["XDG_CACHE_HOME"] = str(self.root / "expendable-cache")
        command = (
            "import sys; "
            "from pathlib import Path; "
            "sys.path.insert(0, sys.argv[1]); "
            "from maintenance_state import state_directory; "
            "print(state_directory('openai/openai-ruby', None))"
        )

        result = subprocess.run(
            [sys.executable, "-B", "-c", command, str(SCRIPT.parent)],
            check=False,
            capture_output=True,
            text=True,
            env=environment,
        )

        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertTrue(
            Path(result.stdout.strip()).is_relative_to(Path.home() / ".local" / "state")
        )


if __name__ == "__main__":
    unittest.main()
