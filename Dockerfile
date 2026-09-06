FROM python:3.14-slim

# Grab the uv binary itself from its own official image — fast installer, no pip needed
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /app

# Copy ONLY the dependency manifests first, and install from them.
# This is the same caching trick as your Node.js Dockerfile: as long as
# these two files don't change, Docker reuses this layer on every rebuild
# and skips reinstalling dependencies — your source code changes far more
# often than your dependencies do, so it goes in a later, separate layer.
COPY pyproject.toml uv.lock README.md ./
RUN uv sync --frozen --no-install-project

# Now copy your actual application code
COPY src/ ./src/
RUN uv sync --frozen

ENV PATH="/app/.venv/bin:$PATH"

CMD ["python", "-m", "mvo.ingest.run_all"]
