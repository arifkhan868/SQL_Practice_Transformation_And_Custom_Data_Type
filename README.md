
# PostgreSQL Advanced Practice: Pivot, Custom & Composite Types, Enum, Range, and Nested Data
---

# Overview:
This repository contains advanced PostgreSQL practice queries, focusing on pivot/unpivot transformations, custom data types, composite types, enum types, range types, and nested data structures. These exercises are designed to build real-world SQL skills and demonstrate the ability to handle both structured and semi-structured data.
---

# 🔹 Topics Covered
# 1. Pivot & Unpivot
- Creating sales table and inserting data
- Pivoting with crosstab and conditional aggregation
- Unpivoting pivoted data using UNION ALL

# 2.Custom Composite Types

- Creating custom type dp for department information
- Using composite type columns in tables
- Accessing individual fields with (column).field_name syntax

# 3.Enum Types

- Creating enum type emts for emotion
- Storing predefined values in tables
- Querying enum type columns

# 4.Range Types

- Creating custom range type call_type for time intervals
- Containment (@>) and overlap (&&) queries
- Filtering based on range values

# 5.Nested / Custom Columns

- Creating composite type qua for question-answer pairs
- Querying nested fields (question).q and (question).a
- Timestamp defaults, update tracking, boolean flags for deletion

---
# 🔹 Sample Queries

---
```sql
-- Pivot Example
SELECT year,
       SUM(CASE WHEN quater = 1 THEN amount END) AS quater1,
       SUM(CASE WHEN quater = 2 THEN amount END) AS quater2
FROM master.sales
GROUP BY year;

-- Composite Type Example
SELECT (dept_info).dept_name, (dept_info).manager_id, (dept_info).description
FROM master.department;

-- Enum Type Example
SELECT * FROM master.emotion WHERE emotion = 'happy';

-- Range Type Example
SELECT * FROM master.callhistory WHERE callduration @> '9:22'::time;

-- Nested Composite Example
SELECT (question).q, (question).a
FROM master.auto_genarated_qa;
```


