---
description: Run performance benchmarks and produce an analysis report
agent: hephaestus
---

Execute performance benchmarks for the current project.

Workflow:
1. Detect the project type and available benchmark tools:
   - Node.js: `npm run bench`, built-in `performance.now()`, vitest bench
   - Python: `pytest-benchmark`, `timeit`
   - Go: `go test -bench`
   - Rust: `cargo bench`
   - Generic: `hyperfine` for CLI tools
2. If benchmarks exist, run them and collect results.
3. If no benchmarks exist, identify the top 3-5 performance-critical paths and propose benchmark implementations.
4. Analyze results for bottlenecks and regressions.

Output format:
- Benchmark results table (operation, iterations, mean time, p95, p99).
- Comparison to previous run if baseline exists.
- Bottleneck analysis with root cause hypothesis.
- Optimization recommendations ranked by expected impact.

Arguments:
- `$ARGUMENTS` can specify: `--baseline` to save as baseline, `--compare` to compare with saved baseline, `--create` to generate new benchmarks.
