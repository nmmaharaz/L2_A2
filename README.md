
# PostgreSQL-এ Primary Key এবং Foreign Key ধারণাগুলি ব্যাখ্যা করো
## 🔑 Primary Key
### Primary Key হলো একটি কলাম বা  দুই বা ততোধিক কলামগুলোর সমষ্টি।

### 📌 বৈশিষ্ট্য (Primary key এর দুইটা বৈশিষ্ট্য):
             * primary key যে কলামে থাকবে ওই কলামে must ডাটা এন্টি করতে হবে। (value কখনো NULL হতে পারে না)
             * যে কলামে primary key থাকবে সে কলামের ডাটা always ইউনিক থাকতে হবে। 

### Primary key ব্যবহার করার নিয়ম:-

```ts
CREATE TABLE students (
  student_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  mark INT
);
```

## 🔑 Foreign Key
### Foreign Key হলো এমন একটি কলাম যা অন্য একটি টেবিলের Primary Key এর সাথে সম্পর্ক (relationship) তৈরি করে। এটি দুইটি টেবিলের মধ্যে সংযোগ স্থাপন করে।

### 📌 বৈশিষ্ট্য:
    * এটি মূলত রেফারেন্স করে অন্য টেবিলের Primary Key কে।
    * এটি নিশ্চিত করে যে যেই মানটি Foreign Key-তে রাখা হয়েছে, সেটা অবশ্যই অন্য টেবিলে আগে থেকেই বিদ্যমান থাকতে হবে (Referential Integrity)।


### Foreign key ব্যবহার করার নিয়ম:-
```ts
CREATE TABLE courses (
  course_id SERIAL PRIMARY KEY,
  course_name VARCHAR(100),
  student_id INT,
  FOREIGN KEY (student_id) REFERENCES students(student_id)
);
```
</br>

#  🆚 VARCHAR এবং CHAR এর মধ্যে পার্থক্য (বাংলায় ব্যাখ্যা)

### VARCHAR আর CHAR — দুটোই string সংরক্ষণের জন্য ব্যবহৃত হয়।

### 🔤 CHAR (Fixed Length Character)
- এটি নির্দিষ্ট দৈর্ঘ্যের (fixed length) ডেটা রাখে।
- ধরো তুমি CHAR(10) দিলে, তাহলে তুমি যত কম অক্ষরই দাও না কেন, সেটা ১০ অক্ষরের জায়গা নিবে। বাকি জায়গা ফাঁকা থাকলে তা space দিয়ে পূরণ হবে।

```ts
CREATE TABLE student (
  name CHAR(10)
);
```

### 🔡 VARCHAR (Variable Length Character)
- এটি পরিবর্তনশীল দৈর্ঘ্যের (variable length) ডেটা রাখে।

- ধরো তুমি VARCHAR(10) দিলে, তাহলে তুমি যত অক্ষর দাও, ততটুকু জায়গাই নিবে। এতে কোনো অতিরিক্ত স্পেস নষ্ট হয় না।

```ts
CREATE TABLE student (
  name VARCHAR(10)
);
```

# 📌LIMIT এবং OFFSET ধারাগুলি কীসের জন্য ব্যবহৃত হয়?

## Limit এর মাধ্যমে আমরা একাধিক ডাটা থেকে আমাদের প্রয়োজন অনুযায়ি ডাটা নিতে পারবো কিন্তূ limit কাজ করার সময় উপর থেকে কাজ করে। 
## Example
আমার কাজ মোট ১০০ টা ডাটা আছে আমি যদি ১০ ডাটা নিতে চাই তাইলে limit ব্যবহার করবো। এইক্ষেত্রে ১-১০ পযন্ত ডাটা দেখাবে।
```ts
SELECT * FROM students
LIMIT 10;
```
## Offset এর মাধ্যমে আমরা একাধিক ডাটা থেকে প্রথম কিছু ডাটা বাদ নিতে অন্য ডাটা গুলো নিতে পারি  
## Example
আমার কাজ মোট ১০০ টা ডাটা আছে আমি যদি ১০-২০ পযন্ত ডাটা নিতে চাই তাইলে Offset ব্যবহার করবো। এইক্ষেত্রে ২০-৩০ পযন্ত ডাটা পাবো।
```ts
SELECT * FROM students
OFFSET 10;
```
# 🔄UPDATE স্টেটমেন্ট ব্যবহার করে আপনি কীভাবে ডেটা পরিবর্তন করতে পারেন?
### UPDATE স্টেটমেন্ট ব্যবহার করে আমরা টেবিলের বিদ্যমান ডেটা পরিবর্তন করতে পারি। এটি সাধারণত তখন ব্যবহৃত হয় যখন কোনো রেকর্ডের তথ্য আপডেট করতে হয়।
### ✅ সাধারণ গঠন (Syntax):
```ts
UPDATE table_name
SET column1 = value1,
    column2 = value2
WHERE condition;
```
- table_name: যেই টেবিলে পরিবর্তন আনতে চাই
- SET: কোন কলামে কী মান বসবে তা নির্ধারণ করে

# 🔹GROUP BY এর কাজ কী?
### GROUP BY হল SQL-এর একটি ক্লজ যা একই ধরনের ডেটাগুলোকে গ্রুপ করে এবং তাদের উপর aggregation (যোগফল, গড়, সর্বোচ্চ ইত্যাদি) অপারেশন চালাতে সাহায্য করে। যেমন:

- SUM() → যোগফল

- AVG() → গড়

- COUNT() → গণনা

- MAX() → সর্বোচ্চ মান

- MIN() → সর্বনিম্ন মান

### ✅Example
```ts
SELECT department, COUNT(*) AS total_students
FROM students
GROUP BY department;
```





