# DevOps Assessment Test

**Assignment: Setting up GKE and Deploying an Application**

**Objective:**

Your task is to demonstrate your proficiency in DevOps practices by setting up Google Kubernetes Engine (GKE) and deploying an application using Terraform, GitHub Actions, Argocd,  and Python.

New customers are eligible for $300 in credits from Google Cloud Platform (GCP). You can leverage this credit for the purpose of this assessment.

**Task 1: Solution**

The terraform folder is organized into two main components: the root module and a separate module for creating a Google Kubernetes Engine (GKE) cluster.

1. **Root Module (main.tf):**

   - **Provider Configuration:** Configures the Google Cloud provider with authentication details and basic settings.
   - **Variables:** Defines variables such as project_id, credentials_file, region, and machine_type to allow customization.
   - **Module Declaration:** Invokes the GKE cluster module using `module "gke_cluster" { source = "./modules/gke_cluster" }`.
   - **Null Resource for kubectl Configuration:** Uses a null_resource to run a local-exec provisioner for configuring kubectl to use the GKE cluster. It depends on the GKE cluster module.

2. **GKE Cluster Module (./modules/gke_cluster/main.tf):**

   - **Variables:** Defines module-specific variables like cluster_name.
   - **Google Container Cluster Resource:** Creates a Google Kubernetes Engine cluster using the `google_container_cluster` resource. The cluster name and location are parameterized.
   - **Output Variable:** Exports an output variable (`gke_cluster_name`) containing the name of the GKE cluster.

The project follows a modular structure, separating concerns between the main configuration and the GKE cluster creation.

**Task 2: Dockerizing the Application**

*Dockerize the provided application. Create a Docker image that encapsulates the application and its dependencies. Share your Dockerfile and any relevant configuration files used in the process.*

**Task 2: Solution**

The `Dockerfile`, located in the root of the project, serves as a blueprint for building the Docker image. It contains instructions for the steps needed to package the application and its dependencies.

To build the Docker image, run the following command in the terminal from the project directory:


`docker build -t wafi-app:latest .`

The Docker image can be pushed to Docker Hub, a popular container registry, for easy sharing and retrieval. Use the following command:

`docker push your-docker-username/wafi-app:latest`

Here is a link to the one in my registry: `https://hub.docker.com/r/root0877/wafi_app`

**Task 3: Continuous Deployment with GitHub Actions and ArgoCD**

*Deploy ArgoCD to manage and automate the continuous delivery of applications on Kubernetes. Set up a GitHub Actions workflow for the application to be automatically deployed to GKE whenever there are new changes in the repo. Provide documentation on the workflow and configuration files used in both GitHub Actions and ArgoCD.*

**Task 3: Solution**

For the CI/CD process with ArgoCD and GitHub Actions, I follow these steps to achieve continuous deployment:

1. **Manifest Files:**
   - Create `deployment.yaml` and `service.yaml` in the manifest folder with configurations for the Kubernetes application.

2. **ArgoCD Setup:**
   - Install ArgoCD on GKE.
   - Log in to ArgoCD to connect the repository.

3. **Application Configuration:**
   - Create an ArgoCD application for the Kubernetes app, linking it to the repository.

4. **GitHub Actions Workflow:**
   - Write a GitHub Actions workflow.
   - Build and push Docker images to the repository on each new change.
   - ArgoCD handles the deployment, pulling and deploying subsequent changes triggered by GitHub Actions.

**Summary:**

The CI/CD process starts with defining Kubernetes manifests (`deployment.yaml` and `service.yaml`) to specify how the application should run. ArgoCD is then installed on GKE, and its connection to the repository is established. An ArgoCD application is configured to monitor changes in the repository and automatically update the deployed application.

The GitHub Actions workflow is designed to build Docker images and push them to the repository upon any changes in the source code. ArgoCD, integrated with GitHub Actions, picks up these changes and orchestrates the deployment to the GKE cluster, ensuring a seamless and automated continuous delivery pipeline.

This setup provides a robust mechanism for managing and deploying applications with the benefits of version control, automated testing, and continuous integration using GitHub Actions, coupled with the declarative and automated deployment capabilities of ArgoCD on GKE.


**Questions for Explanation:**

1. **Explain how you would scale the application within the GKE cluster.**

   **Answer:**
   To scale the application within the GKE cluster, I would employ horizontal pod autoscaling (HPA) based on metrics like CPU utilization or custom metrics. This allows the cluster to dynamically adjust the number of pods based on workload. Additionally, I would consider deploying a multi-node pool setup to better utilize resources and distribute workloads efficiently.

2. **Outline the measures taken to ensure the reliability of the application on GKE, considering factors like fault tolerance and high availability.**

   **Answer:**
   To ensure reliability, fault tolerance, and high availability, I would:
   - Implement a multi-zone deployment to withstand zone failures.
   - Utilize GKE's node auto-repair feature to automatically replace failed nodes.
   - Set up Kubernetes probes for health and readiness checks to handle container failures gracefully.
   - Deploy redundant instances of critical components using ReplicaSets to ensure continuous service availability.

3. **Elaborate on the security measures that can be implemented to safeguard the application.**

    **Answer:**
    For security:
    - Enforce network policies to restrict communication between pods.
    - Implement Pod Security Policies (PSP) to control pod behavior.
    - Utilize Google Kubernetes Engine's (GKE) NodePool features, like Shielded VMs and node auto-upgrade, for enhanced security at the infrastructure level.
    - Regularly update and patch underlying OS and software components.
    - Implement secrets management using Kubernetes secrets and avoid hardcoding sensitive information in manifests.

4. **Discuss how you would handle migration, secrets, and environment variables.**

   **Answer:**
   1. For application migration, I would version control Kubernetes manifests and Helm charts, making updates traceable and manageable.
   2. Secrets would be managed using Kubernetes Secrets or external secret management tools, ensuring encryption in transit and at rest.
   3. Environment variables would be set using ConfigMaps or directly within deployment configurations, enabling easy configuration changes without modifying code.
   4. For sensitive data, such as database credentials, I would use Kubernetes Secrets or external secret management tools to maintain security during deployments and updates.


**Submission Guidelines:**
- Provide a link to the GitHub repository containing your Terraform scripts, Dockerfile, GitHub Actions workflow, and ArgoCD configuration.
- Include documentation that explains the setup, rationale behind design choices, and steps for scaling and securing the application.

`https://docs.google.com/document/d/1pN1DbRJvK_dd5COtD18t-Z6IqgjPzxoHiENESiOeMZM/edit`

This assessment aims to evaluate your ability to implement DevOps practices effectively and make informed decisions in configuring and securing a GKE deployment. Feel free to dazzle with your solutions. Good luck!
