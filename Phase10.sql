-- so, single column index is just indexing using a value of a column that can be very unique across the rows which you call cardinality.
-- composite indexing is (customer_id, status, created_at) but here, only the column from the left take advantage of indexing, like customer, customer+status..., but not status alone or created_at alone)
-- and I can also do composite indexing like (customer_id, created_at DESC) this means, that the created_at column in customer_id is sorted in DESC order whcih help for the query even.

-- and partial indexing sounds scary but it's either a single column indexing or a composite indexing with a WHERE condition 💀



