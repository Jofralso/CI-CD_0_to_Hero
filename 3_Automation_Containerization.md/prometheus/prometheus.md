# Source Code Revision and Monitoring Tools - Prometheus

## Overview

Prometheus is an open-source monitoring and alerting toolkit designed for reliability and scalability. It is particularly well-suited for capturing metrics from applications, services, and systems in real-time, offering powerful querying capabilities and integration with visualization tools like Grafana.

## Detailed Explanation

### Basic Concepts

- **Metrics**: Data points collected from monitored systems. Metrics are typically time-series data that include a timestamp and a value.

- **Prometheus Server**: Collects and stores metrics data. It scrapes data from configured targets at specified intervals.

- **Scraping**: The process by which Prometheus fetches metrics data from endpoints exposed by monitored services.

- **Exporters**: Components that expose metrics in a format Prometheus can scrape. Common exporters include those for system metrics (node_exporter) and application metrics.

- **Query Language (PromQL)**: Prometheus Query Language allows users to query and manipulate time-series data. It supports operations like aggregations, filtering, and mathematical functions.

### Advanced Concepts

- **Service Discovery**: Prometheus supports various service discovery mechanisms to dynamically find and scrape targets. This includes Kubernetes, Consul, and static configurations.

- **Alerting**: Prometheus supports alerting based on metric thresholds. Alerts are configured in Prometheus and can be sent to Alertmanager for notification.

- **Recording Rules**: Used to precompute frequently used queries and store the results as new time series, which helps in optimizing performance and query efficiency.

- **Labels and Label Selectors**: Labels are key-value pairs attached to metrics. They are used to categorize and filter metrics in queries.

## Setup and Installation

### Installing Prometheus

1. **On Linux**:
   - **Download and Install**:
     ```bash
     wget https://github.com/prometheus/prometheus/releases/download/v2.43.0/prometheus-2.43.0.linux-amd64.tar.gz
     tar xvfz prometheus-2.43.0.linux-amd64.tar.gz
     cd prometheus-2.43.0.linux-amd64
     sudo cp prometheus /usr/local/bin/
     sudo cp promtool /usr/local/bin/
     sudo mkdir /etc/prometheus
     sudo cp prometheus.yml /etc/prometheus/
     ```

   - **Start Prometheus**:
     ```bash
     prometheus --config.file=/etc/prometheus/prometheus.yml
     ```

2. **On macOS**:
   - **Install with Homebrew**:
     ```bash
     brew install prometheus
     ```

   - **Start Prometheus**:
     ```bash
     prometheus --config.file=/usr/local/etc/prometheus.yml
     ```

3. **On Windows**:
   - **Download the Installer** from the [Prometheus website](https://prometheus.io/download/).
   - **Extract and Configure**:
     ```powershell
     tar xvfz prometheus-2.43.0.windows-amd64.tar.gz
     cd prometheus-2.43.0.windows-amd64
     .\prometheus.exe --config.file=prometheus.yml
     ```

4. **Access Prometheus**:
   - Open your web browser and go to `http://localhost:9090`. This is the Prometheus web UI where you can execute queries and view metrics.

### Basic Commands

- **Start Prometheus Server**:
  ```bash
  prometheus --config.file=/path/to/prometheus.yml
  ```

- **Check Prometheus Status**:
  - Visit `http://localhost:9090/-/health` for health status.

- **Reload Configuration**:
  ```bash
  curl -X POST http://localhost:9090/-/reload
  ```

## Resources

- [Prometheus Official Documentation](https://prometheus.io/docs/)
- [Prometheus GitHub Repository](https://github.com/prometheus/prometheus)
- [Prometheus Query Language (PromQL) Guide](https://prometheus.io/docs/prometheus/latest/querying/basics/)

## Exercises

### Easy Problem

**Task**: Install Prometheus and configure it to scrape metrics from a static target.

**Solution**:

1. **Install Prometheus** using the instructions for your operating system.
2. **Configure Prometheus**:
   - Edit the `prometheus.yml` file to add a static target:
     ```yaml
     global:
       scrape_interval: 15s

     scrape_configs:
       - job_name: 'example'
         static_configs:
           - targets: ['localhost:9091']
     ```
3. **Start Prometheus** and verify that it is scraping metrics from the configured target:
   - Use the Prometheus web UI (`http://localhost:9090`) to query and see metrics from `example`.

### Medium Problem

**Task**: Set up Prometheus to scrape metrics from a Node Exporter and create a basic Grafana dashboard to visualize system metrics.

**Solution**:

1. **Install Node Exporter**:
   - Download and run Node Exporter:
     ```bash
     wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
     tar xvfz node_exporter-1.5.0.linux-amd64.tar.gz
     cd node_exporter-1.5.0.linux-amd64
     ./node_exporter
     ```

2. **Configure Prometheus**:
   - Edit `prometheus.yml` to include Node Exporter:
     ```yaml
     scrape_configs:
       - job_name: 'node_exporter'
         static_configs:
           - targets: ['localhost:9100']
     ```

3. **Create Grafana Dashboard**:
   - Add Prometheus as a data source in Grafana.
   - Create a new dashboard and add panels using queries like `node_cpu_seconds_total` to visualize CPU usage.

### Hard Problem

**Task**: Configure Prometheus with advanced features including recording rules and alerting. Set up an alert for high CPU usage and visualize the alerts in Grafana.

**Solution**:

1. **Add Recording Rules**:
   - Edit `prometheus.yml` to include recording rules:
     ```yaml
     rule_files:
       - "rules.yml"
     ```

   - Create `rules.yml`:
     ```yaml
     groups:
     - name: example
       rules:
       - record: job:cpu_usage:avg
         expr: avg(rate(node_cpu_seconds_total[5m])) by (job)
     ```

2. **Set Up Alerts**:
   - Add alerting rules to `rules.yml`:
     ```yaml
     groups:
     - name: example
       rules:
       - alert: HighCPUUsage
         expr: avg(rate(node_cpu_seconds_total[5m])) by (job) > 0.8
         for: 5m
         labels:
           severity: critical
         annotations:
           summary: "High CPU usage detected"
           description: "CPU usage is above 80% for more than 5 minutes."
     ```

3. **Configure Alertmanager**:
   - Follow the [Alertmanager documentation](https://prometheus.io/docs/alerting/latest/alertmanager/) to set up Alertmanager and configure it to send notifications.

4. **Visualize Alerts in Grafana**:
   - Add Alertmanager as a data source in Grafana.
   - Create a new dashboard and add panels to visualize active alerts.

## Cheat Sheet

### Basic Prometheus Commands

- **Start Prometheus**:
  ```bash
  prometheus --config.file=/path/to/prometheus.yml
  ```

- **Reload Configuration**:
  ```bash
  curl -X POST http://localhost:9090/-/reload
  ```

- **Check Health Status**:
  - Visit `http://localhost:9090/-/health`.

### PromQL Basics

- **Simple Query**:
  ```promql
  up
  ```

- **Rate Over Time**:
  ```promql
  rate(node_cpu_seconds_total[5m])
  ```

- **Average Over Time**:
  ```promql
  avg(rate(node_cpu_seconds_total[5m])) by (job)
  ```

- **Alerting Rule Example**:
  ```yaml
  alert: HighCPUUsage
  expr: avg(rate(node_cpu_seconds_total[5m])) by (job) > 0.8
  for: 5m
  ``` 