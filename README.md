# dump grafana configured resources

## datasources

```sh
./dump-datasources.sh <url> <api-key>
```

## dashboards

```sh
./dump-dashboards.sh <url> <api-key>
```

## alertrules

They can be exported from the UI

```none
Export from the Grafana UI
The export options listed below enable you to download resources in YAML, JSON, or Terraform format, facilitating their provisioning through configuration files or Terraform.

Export alert rules
To export alert rules from the Grafana UI, complete the following steps.

- Click Alerts & IRM -> Alert rules.
- To export all Grafana-managed rules, click Export rules.
- To export a folder, change the View as to List.
- Select the folder you want to export and click the Export rules folder icon.
- To export a group, change the View as to Grouped.
- Find the group you want to export and click the Export rule group icon.
- Choose the format to export in.
- The exported alert rule data appears in different formats - YAML, JSON, Terraform.
- Click Copy Code or Download.
```

source: https://grafana.com/docs/grafana/latest/alerting/set-up/provision-alerting-resources/export-alerting-resources/
