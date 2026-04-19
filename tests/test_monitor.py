import unittest
from unittest.mock import MagicMock, patch
import os
import sys

# Add the pipeline directory to sys.path
sys.path.append(os.path.join(os.path.dirname(__file__), '../pipeline'))
import pipeline_monitor

class TestVFXMonitor(unittest.TestCase):
    @patch('boto3.client')
    def test_bottleneck_detection(self, mock_boto):
        monitor = pipeline_monitor.VFXPipelineMonitor("test-cluster")
        # Scenario: High queue, low nodes
        report = monitor.check_pipeline_health(active_render_nodes=1, queue_depth=500)
        
        self.assertEqual(report['status'], "CRITICAL BOTTLENECK")
        self.assertIn("Auto-Scaling", report['recommendation'])

    @patch('boto3.client')
    def test_stalled_pipeline(self, mock_boto):
        monitor = pipeline_monitor.VFXPipelineMonitor("test-cluster")
        # Scenario: 0 nodes
        report = monitor.check_pipeline_health(active_render_nodes=0, queue_depth=10)
        
        self.assertEqual(report['status'], "PIPELINE STALLED")
        self.assertIn("Restarting", report['recommendation'])

if __name__ == '__main__':
    unittest.main()
