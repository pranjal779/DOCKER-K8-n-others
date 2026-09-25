A Kubernetes cluster relies on a classic client-server model split into two main sections: the Control Plane (Master Node), which serves as the "brain" making global decisions, and Worker Nodes, which act as the "muscle" running your actual applications. [1, 2] 
Here is how their core components break down and work together:

------------------------------
## 1. Control Plane (Master Node)
The Control Plane is responsible for managing the entire cluster. It monitors the health of the system, schedules applications, and responds to cluster events. [3, 4] 

* API Server (kube-apiserver): The front door to Kubernetes. Every single internal component and external user command (kubectl) must talk to the API Server. It handles request validation and configuration. [1, 3, 5] 
* etcd: The cluster's database. It is a highly available, distributed key-value store that holds the single source of truth for the entire cluster state. [4, 6, 7] 
* Scheduler (kube-scheduler): The matchmaker. It watches for newly created application containers (Pods) that don't have a home yet and selects the best worker node for them based on resource needs and constraints. [5, 8] 
* Controller Manager (kube-controller-manager): The overseer. It runs background control loops that constantly compare the cluster's actual state against your desired state. For example, if a node crashes, the node controller notices and schedules new workloads to replace the lost ones. [4, 5] 
* Cloud Controller Manager (cloud-controller-manager): The cloud translator. It links your cluster to your cloud provider's API (like AWS, Azure, or GCP) to manage cloud-specific resources like load balancers and storage volumes. [6, 9] 

------------------------------
## 2. Worker Node
Worker Nodes receive instructions from the Control Plane and do the actual work of running your application workloads. [1, 6] 

* Kubelet: The captain of the node. It is an agent running on every single worker node that takes instructions directly from the API Server. It ensures that the specified containers are actually running and healthy inside their Pods. [5, 10, 11] 
* Kube-proxy (kube-proxy): The network traffic director. It maintains network rules on the host machine. These rules handle internal and external network traffic routing so your containers can seamlessly talk to each other and the outside world. [4, 10, 12] 
* Container Runtime: The engine that executes containers. Kubernetes doesn't actually run containers directly; it uses a software runtime (like containerd or CRI-O) to pull container images from a registry and physically start or stop them. [2, 4, 11] 

Would you like to explore how a request flows through these components when you deploy an app, or should we look closer at how they communicate securely?

[1] [https://www.youtube.com](https://www.youtube.com/watch?v=NfVifspmz9k)
[2] [https://www.geeksforgeeks.org](https://www.geeksforgeeks.org/devops/kubernetes-architecture/)
[3] [https://dev.to](https://dev.to/latchudevops/part-76-kubernetes-architecture-explained-master-worker-nodes-mkb)
[4] [https://www.youtube.com](https://www.youtube.com/watch?v=V5TVWGV8WwU&t=694)
[5] [https://www.youtube.com](https://www.youtube.com/watch?v=klxZke9qbvg&t=6)
[6] [https://devtron.ai](https://devtron.ai/blog/kubernetes-architecture-the-ultimate-guide/)
[7] [https://www.sparkfabrik.com](https://www.sparkfabrik.com/en/blog/kubernetes-architecture-guide-to-components/)
[8] [https://www.civo.com](https://www.civo.com/academy/kubernetes-concepts/kubernetes-architecture)
[9] [https://kubernetes.io](https://kubernetes.io/docs/concepts/architecture/)
[10] [https://www.qovery.com](https://www.qovery.com/blog/what-is-kubernetes-architecture)
[11] [https://medium.com](https://medium.com/@vikwaso/kubernetes-architecture-a-deep-dive-into-the-core-components-b93a953019d1)
[12] [https://www.sysdig.com](https://www.sysdig.com/learn-cloud-native/components-of-kubernetes)
