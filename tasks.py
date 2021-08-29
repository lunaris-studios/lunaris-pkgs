# @author      Sam Craig <sam@talisman.dev>
# @link        https://github.com/talismanco/talismanpkgs
# ------------------------------------------------------------------------------


from invoke import Collection, task

import dotenv
import os

# === SETUP ===


@task()
def _clean(context):
    context.run(
        "find . -type f -name '.env.*' -o -name '*.env' | xargs rm -f")


@task(pre=[_clean])
def _setup(context, stage="development"):
    context.run(f'python ./scripts/python/setup.py {rootdir} {stage}')

    # Instantiate the environment variables in `.env`
    # and `.tool-versions.env` via `dotenv`.
    dotenv.load_dotenv(".env")
    dotenv.load_dotenv(".tool-versions.env")

    # Set the project commit hash.
    os.environ["PROJECT_COMMIT"] = sstrings.normalize(subprocess.check_output(
        ["git", "rev-parse", "HEAD"]))

    # Set the current operating system & CPU architecture of the current
    # developmentenvironment
    os.environ["PROJECT_SYSTEM"] = platform.system().lower()
    os.environ["PROJECT_ARCH"] = platform.machine().lower()

# === CREATE ===


@task(pre=[_setup], aliases=["c"])
def create(context, name, version):
    """
    Scaffold new package dirtory & files
    """
    context.run(f'mkdir -p ./pkgs/{name}')
    context.run(f'mkdir -p ./pkgs/{name}/versions')

    context.run(f'touch ./pkgs/{name}/default.nix')
    context.run(f'touch ./pkgs/{name}/versions/{version}.nix')


# === UPDATE ===


@task(pre=[_setup], default=True, name="all")
def update_all(context):
    """
    Run all `update` tasks
    """
    update_modules(context)
    update_niv(context)
    update_npm(context)


@task(pre=[_setup], name="modules")
def update_modules(context):
    """
    Update git sub-modules
    """
    context.run("git submodule update --init --recursive --remote")

@task(pre=[_setup], name="niv")
def update_niv(context):
    """
    Update niv dependencies
    """
    context.run("niv update")


@task(pre=[_setup], name="npm")
def update_npm(context):
    """
    Update npm packages
    """
    context.run("npm run update")


update = Collection("update", update_all)
update.add_task(update_modules)
update.add_task(update_niv)
update.add_task(update_npm)

#

ns = Collection()
ns.add_task(create)

ns.add_collection(update)
