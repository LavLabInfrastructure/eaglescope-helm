# Eaglescope Helm Chart

This Helm chart deploys Eaglescope, a cohort visualization service, along with optional data source containers that should serve JSON or CSV responses on the first port defined in extraContainers.ports[0].containerPort. The chart configures Nginx to reverse proxy requests to these containers and to the Eaglescope service. The landing page is highly recommended for multiple eaglescope configurations, and not optional for pages using extra containers as datasources, although you're more than welcome to bind a volume for a static datasource to disable the landing page.

## Installation

To install the chart with the release name `eaglescope`:

```sh
helm install eaglescope ./eaglescope
```

## Values

The following table lists the configurable parameters of the Eaglescope chart and their default values.

| Parameter                | Description                                         | Default                         |
|--------------------------|-----------------------------------------------------|---------------------------------|
| `replicaCount`           | Number of replicas for the Eaglescope deployment    | `1`                             |
| `image.repository`       | Eaglescope image repository                         | `your-docker-repo/eaglescope`   |
| `image.pullPolicy`       | Image pull policy                                   | `IfNotPresent`                  |
| `image.tag`              | Image tag                                           | `latest`                        |
| `service.type`           | Kubernetes service type                             | `ClusterIP`                     |
| `service.port`           | Kubernetes service port                             | `80`                            |
| `extraContainers`        | List of additional containers                       | `[]`                            |
| `extraVolumes`           | List of additional volumes                          | `[]`                            |
| `extraVolumeMounts`      | List of additional volume mounts                    | `[]`                            |
| `env`                    | Environment variables for Eaglescope                | `{}`                            |
| `config.configMapName`   | Name of the config map to use                       | `""`                            |
| `config.files`           | Configuration files                                 | `{}`                            |
| `landingPage.enabled`    | Enable or disable the landing page                  | `true`                          |
| `landingPage.customHtml` | Custom HTML for the landing page                    | `""`                            |
| `ingress.enabled`        | Enable or disable ingress                           | `false`                         |
| `ingress.annotations`    | Annotations for the ingress                         | `{}`                            |
| `ingress.hosts`          | List of ingress hosts                               | `[]`                            |
| `ingress.tls`            | List of TLS configurations for the ingress          | `[]`                            |
| `resources`              | Resource limits and requests                        | `{}`                            |
| `nodeSelector`           | Node selector for pod assignment                    | `{}`                            |
| `tolerations`            | Tolerations for pod assignment                      | `[]`                            |
| `affinity`               | Affinity settings for pod assignment                | `{}`                            |

## Customizing the Chart

To customize the chart, you can pass in custom values using the `--set` flag or by providing a custom `values.yaml` file. Here are some examples:

### Using the `--set` Flag

```sh
helm install eaglescope ./eaglescope --set replicaCount=2 --set image.tag=v1.0.0
```

### Using a Custom `values.yaml` File

Create a `values.yaml` file with your custom values:

```yaml
replicaCount: 2
image:
  tag: v1.0.0
extraContainers:
  - name: example
    image: example-datasource:latest
    resources:
      limits:
        cpu: "100m"
        memory: "128Mi"
      requests:
        cpu: "50m"
        memory: "64Mi"
    env:
      - name: EXAMPLE_ENV
        value: "example_value"
```

Install the chart using your custom `values.yaml` file:

```sh
helm install eaglescope ./eaglescope -f values.yaml
```

## Accessing the Landing Page

If the landing page is enabled, it will be accessible at the root of the ingress host. The landing page will list links to different configuration pages based on the provided configuration files.

## Adding Data Source Containers

You can add additional containers to serve as data sources by specifying them in the `extraContainers` section of the `values.yaml` file. These containers will be reverse proxied by Nginx, and each container's name will be used as the route path.

Example `values.yaml`:

```yaml
extraContainers:
  - name: example
    image: example-datasource:latest
  - name: another-example
    image: another-datasource:latest
```

This configuration will create reverse proxy rules for `/example` and `/another-example`.

## Uninstalling the Chart

To uninstall/delete the `eaglescope` deployment:

```sh
helm uninstall eaglescope
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

