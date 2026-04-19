# [GUARD] VFX Sentinel: Automated Pipeline Observability

## Project Overview
VFX Sentinel is a Proof of Concept (PoC) demonstrating **Automated Cloud Operations** specifically tailored for high-throughput VFX rendering pipelines.

In a production environment like Framestore's, rendering microservices must scale dynamically while maintaining 100% stability. This tool automates the "Monitor-Reason-Remediate" cycle for EKS-based render nodes.

## [FEATURE] The Edge: Why This Matters for Framestore
*   **Production-Focused DevOps:** Specifically designed to solve the "Bottleneck vs. Cost" challenge in large-scale rendering.
*   **Dynamic Scaling Logic:** Uses operational reasoning to trigger spot-instance scaling during high-pressure production cycles.
*   **Automated Incident Response:** Detects stalled pipelines and automatically verifies infrastructure health, reducing manual NOC intervention.

## [STACK] Technical Stack
*   **Infrastructure:** Terraform (AWS EKS & S3)
*   **Observability:** CloudWatch Alarms
*   **Logic Engine:** Python (VFX Pipeline Monitor)
*   **Lifecycle Management:** S3 Lifecycle Rules (Storage Efficiency)

## [START] How It Works
1.  **Monitor:** The monitor ingestion queue depth and active render node counts.
2.  **Reason:** The logic identifies if a production bottleneck exists (e.g., "Queue is high but nodes are low").
3.  **Act:** The agent suggests or triggers scaling actions to clear the queue using cost-effective compute (Spot Instances).
4.  **Validate:** The infrastructure is managed via Terraform to ensure consistent, repeatable environments for every film project.

## [SETUP] Local Demo
You can simulate the VFX operational reasoning locally:
```bash
# Run the pipeline health simulation
make monitor
```

---
**Built for the Framestore Launchpad Technology Team by Aegis Agent.**
