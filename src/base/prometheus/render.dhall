let Kubernetes/List = ../../util/kubernetes-list.dhall

let Kubernetes/TypesUnion = ../../deps/k8s/typesUnion.dhall

let Configuration/global = ../../configuration/global.dhall

let component = ./component.dhall

let Generate = ./generate.dhall

let ToList =
        ( λ(c : component) →
            Kubernetes/List::{
            , items =
              [ Kubernetes/TypesUnion.Deployment c.Deployment
              , Kubernetes/TypesUnion.ClusterRole c.ClusterRole
              , Kubernetes/TypesUnion.ConfigMap c.ConfigMap
              , Kubernetes/TypesUnion.PersistentVolumeClaim
                  c.PersistentVolumeClaim
              , Kubernetes/TypesUnion.ClusterRoleBinding c.ClusterRoleBinding
              , Kubernetes/TypesUnion.ServiceAccount c.ServiceAccount
              , Kubernetes/TypesUnion.Service c.Service
              ]
            }
        )
      : ∀(c : component) → Kubernetes/List.Type

let Render =
        (λ(c : Configuration/global.Type) → ToList (Generate c))
      : ∀(c : Configuration/global.Type) → Kubernetes/List.Type

in  Render
