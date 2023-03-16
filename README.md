# Gen Distribution Zoo

Repo for all sorts of Gen distributions ....

- Module: `GenDistributionZoo`

So far we have:

- `diagnormal`: 
	- Diagonal Gaussian (faster than `mvnormal`)
	- There already is a `broadcasted_normal` &mdash; it's similar in performance
- `ProductDistribution`: 
	- `HomogeneousProduct`
	- <s>`HeterogeneousProduct`</s> wrong args, under constr ...
	- One can specify the dimension along which the args of each distribution are "stacked".
	
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