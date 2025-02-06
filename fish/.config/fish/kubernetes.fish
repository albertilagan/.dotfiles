# k8s
alias k kubectl
alias kw "watch kubectl"
alias kctx kubectx
alias kns kubens
abbr kpf "kubectl port-forward"
abbr kg "kubectl get"
abbr kd "kubectl describe"

# flux
abbr fr "flux reconcile"
abbr frk "flux reconcile kustomization"
abbr frhr "flux reconcile hr"

set -e KUBECONFIG
set -x KUBECONFIG (string join ':' (find ~/.kube/shoots -type f -name '*.yaml'))


# terraform
abbr tf "terraform"
