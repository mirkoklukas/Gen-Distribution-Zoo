# Gen Distribution Zoo

Repo for all sorts of Gen distributions ....

- Module: `GenDistributionZoo`

So far we have:

- `diagnormal`: Diagonal Gaussian (faster than `mvnormal`)
- `ProductDistribution`: ...
- `PushForward`: ... 
- ...

## Example

```
using BenchmarkTools
using Gen: logpdf, mvnormal
using GenDistributionZoo: diagnormal

n    = 1_000
mus  = rand(n);
stds = ones(n);s
xs   = rand(n);

@btime diagnormal($mus, $stds); 
@btime logpdf($diagnormal, $xs, $mus, $stds); 
# >> 4.847 μs (1 allocation: 7.94 KiB)
# >> 6.006 μs (0 allocations: 0 bytes)
```