# [Architecture](https://grafana.com/docs/loki/latest/get-started/architecture/)

Loki is comprised of eight microservices, that fall into categories supporting the read path, the write path, and backend services responsible
for coordinating cluster operations.  The services for each "category" can be deployed as individual units, consisting of the microservices
supporting the read, write, or backend operations.  Loki can be deployed in three distinct modes: Monolithic, Simple Scalable, and
Microservices.  The monolithic deployment is primarily useful for small log volumes, approximately 20GB per day.  The simple scalable
deployment is recommended, and will support "up to a few TB of logs per day".  Supporting larger logging volumes requires adopting the
microservices deployment model, allowing individual components to be scaled as needed.  Operating multiple regional Loki clusters is
certainly an option for adopting the simple scalable deployment with larger logging workloads.

## Components

## [Consistent Hash rings](https://grafana.com/docs/loki/latest/get-started/hash-rings/)

Loki uses consistent hash rings for several purposes.  The one pertinent to our interests is how hash rings are used to track cluster
membership.  Loki supports several key/value stores for this purpose, including Consul, etcd, and
[`memberlist`](https://github.com/hashicorp/memberlist).  `memberlist` is an implementation of the 
[SWIM Protocol -(S)calable (W)eakly-consistent (I)nfection-style Process Group (M)embership Protocol](https://www.cs.cornell.edu/projects/Quicksilver/public_pdfs/SWIM.pdf).
`memberlist` includes extensions to the base SWIM protocol, detailed in the paper [`Lifeguard: SWIM-ing with Situational Awareness`](https://arxiv.org/pdf/1707.00788).
