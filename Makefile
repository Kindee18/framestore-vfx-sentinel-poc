.PHONY: monitor test help

help:
	@echo "Framestore VFX Sentinel PoC: Automated Pipeline Monitoring"
	@echo ""
	@echo "Usage:"
	@echo "  make monitor    Run the VFX Pipeline Health Monitor (simulation)"
	@echo "  make test       Run unit tests for the monitor logic"

monitor:
	@echo "[VFX] Starting VFX Pipeline Audit..."
	@python3 pipeline/pipeline_monitor.py

test:
	@echo "[SETUP] Running logic verification..."
	@python3 -m unittest tests/test_monitor.py
