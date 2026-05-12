---
source_url: https://arxiv.org/abs/2005.14165
ingested: 2026-05-12
---

# Language Models are Few-Shot Learners

---

## Metadata

| Field | Value |
|-------|-------|
| **arXiv ID** | `2005.14165v4` |
| **Title** | Language Models are Few-Shot Learners |
| **Published** | 2020-05-28T17:29:03Z |
| **Updated** | 2020-07-22T19:47:17Z |
| **Primary Category** | cs.CL |
| **Authors** | Tom B. Brown, Benjamin Mann, Nick Ryder, Melanie Subbiah, Jared Kaplan, Prafulla Dhariwal, Arvind Neelakantan, Pranav Shyam, Girish Sastry, Amanda Askell, Sandhini Agarwal, Ariel Herbert-Voss, Gretchen Krueger, Tom Henighan, Rewon Child, Aditya Ramesh, Daniel M. Ziegler, Jeffrey Wu, Clemens Winter, Christopher Hesse, Mark Chen, Eric Sigler, Mateusz Litwin, Scott Gray, Benjamin Chess, Jack Clark, Christopher Berner, Sam McCandlish, Alec Radford, Ilya Sutskever, Dario Amodei |
| **Number of Authors** | 31 |
| **Comments** | 40+32 pages |
| **PDF** | [https://arxiv.org/pdf/2005.14165v4](https://arxiv.org/pdf/2005.14165v4) |
| **Abstract Page** | [https://arxiv.org/abs/2005.14165v4](https://arxiv.org/abs/2005.14165v4) |

### Author List

1. **Tom B. Brown**
2. **Benjamin Mann**
3. **Nick Ryder**
4. **Melanie Subbiah**
5. **Jared Kaplan**
6. **Prafulla Dhariwal**
7. **Arvind Neelakantan**
8. **Pranav Shyam**
9. **Girish Sastry**
10. **Amanda Askell**
11. **Sandhini Agarwal**
12. **Ariel Herbert-Voss**
13. **Gretchen Krueger**
14. **Tom Henighan**
15. **Rewon Child**
16. **Aditya Ramesh**
17. **Daniel M. Ziegler**
18. **Jeffrey Wu**
19. **Clemens Winter**
20. **Christopher Hesse**
21. **Mark Chen**
22. **Eric Sigler**
23. **Mateusz Litwin**
24. **Scott Gray**
25. **Benjamin Chess**
26. **Jack Clark**
27. **Christopher Berner**
28. **Sam McCandlish**
29. **Alec Radford**
30. **Ilya Sutskever**
31. **Dario Amodei**

---

## Abstract

> Recent work has demonstrated substantial gains on many NLP tasks and benchmarks by pre-training on a large corpus of text followed by fine-tuning on a specific task. While typically task-agnostic in architecture, this method still requires task-specific fine-tuning datasets of thousands or tens of thousands of examples. By contrast, humans can generally perform a new language task from only a few examples or from simple instructions - something which current NLP systems still largely struggle to do. Here we show that scaling up language models greatly improves task-agnostic, few-shot performance, sometimes even reaching competitiveness with prior state-of-the-art fine-tuning approaches. Specifically, we train GPT-3, an autoregressive language model with 175 billion parameters, 10x more than any previous non-sparse language model, and test its performance in the few-shot setting. For all tasks, GPT-3 is applied without any gradient updates or fine-tuning, with tasks and few-shot demonstrations specified purely via text interaction with the model. GPT-3 achieves strong performance on many NLP datasets, including translation, question-answering, and cloze tasks, as well as several tasks that require on-the-fly reasoning or domain adaptation, such as unscrambling words, using a novel word in a sentence, or performing 3-digit arithmetic. At the same time, we also identify some datasets where GPT-3's few-shot learning still struggles, as well as some datasets where GPT-3 faces methodological issues related to training on large web corpora. Finally, we find that GPT-3 can generate samples of news articles which human evaluators have difficulty distinguishing from articles written by humans. We discuss broader societal impacts of this finding and of GPT-3 in general.

*(1789 characters)*

---

## Categories

| Category | Description |
|----------|-------------|
| `cs.CL` | CL |

**Primary Category:** `cs.CL`

---

## Submission History

- **Originally submitted:** 2020-05-28T17:29:03Z UTC
- **Last updated:** 2020-07-22T19:47:17Z UTC

---

## Full Entry (arXiv API Raw Content)

Below is the complete raw text extracted from the arXiv API response for this paper. This is the original abstract as submitted by the authors, without any modification or summarization.

### Raw Abstract Text

```
Recent work has demonstrated substantial gains on many NLP tasks and benchmarks by pre-training on a large corpus of text followed by fine-tuning on a specific task. While typically task-agnostic in architecture, this method still requires task-specific fine-tuning datasets of thousands or tens of thousands of examples. By contrast, humans can generally perform a new language task from only a few examples or from simple instructions - something which current NLP systems still largely struggle to do. Here we show that scaling up language models greatly improves task-agnostic, few-shot performance, sometimes even reaching competitiveness with prior state-of-the-art fine-tuning approaches. Specifically, we train GPT-3, an autoregressive language model with 175 billion parameters, 10x more than any previous non-sparse language model, and test its performance in the few-shot setting. For all tasks, GPT-3 is applied without any gradient updates or fine-tuning, with tasks and few-shot demonstrations specified purely via text interaction with the model. GPT-3 achieves strong performance on many NLP datasets, including translation, question-answering, and cloze tasks, as well as several tasks that require on-the-fly reasoning or domain adaptation, such as unscrambling words, using a novel word in a sentence, or performing 3-digit arithmetic. At the same time, we also identify some datasets where GPT-3's few-shot learning still struggles, as well as some datasets where GPT-3 faces methodological issues related to training on large web corpora. Finally, we find that GPT-3 can generate samples of news articles which human evaluators have difficulty distinguishing from articles written by humans. We discuss broader societal impacts of this finding and of GPT-3 in general.
```

---

## Detailed Metadata Analysis

### Paper Identification

This paper is identified by the arXiv identifier `2005.14165v4` and is available under the primary category of `cs.CL`. The paper was first submitted on 2020-05-28T17:29:03Z and the most recent version was updated on 2020-07-22T19:47:17Z. The work was authored by 31 researchers.

### Author Comments

The authors provided the following additional information: _40+32 pages_

### Authors and Contributions

The paper has a total of 31 authors. Below is the complete ordered list of authors as they appear in the arXiv metadata:

1st author: Tom B. Brown
2nd author: Benjamin Mann
3rd author: Nick Ryder
4th author: Melanie Subbiah
5th author: Jared Kaplan
6th author: Prafulla Dhariwal
7th author: Arvind Neelakantan
8th author: Pranav Shyam
9th author: Girish Sastry
10th author: Amanda Askell
11th author: Sandhini Agarwal
12th author: Ariel Herbert-Voss
13th author: Gretchen Krueger
14th author: Tom Henighan
15th author: Rewon Child
16th author: Aditya Ramesh
17th author: Daniel M. Ziegler
18th author: Jeffrey Wu
19th author: Clemens Winter
20th author: Christopher Hesse
21th author: Mark Chen
22th author: Eric Sigler
23th author: Mateusz Litwin
24th author: Scott Gray
25th author: Benjamin Chess
26th author: Jack Clark
27th author: Christopher Berner
28th author: Sam McCandlish
29th author: Alec Radford
30th author: Ilya Sutskever
31th author: Dario Amodei

### Subject Categories

The paper is classified under the following arXiv categories:

- `cs.CL`

The primary subject category is **cs.CL**, which indicates the main research area of this paper. The additional categories provide context on secondary areas that this work touches upon or contributes to.

### Version Information

The arXiv API returns the most recent version of this paper. The paper was originally published on 2020-05-28T17:29:03Z UTC and was last revised on 2020-07-22T19:47:17Z UTC. The arXiv ID includes a version suffix (e.g., v1, v2, etc.) indicating the revision number.

### Access Links

- **Abstract page:** [https://arxiv.org/abs/2005.14165v4](https://arxiv.org/abs/2005.14165v4)
- **PDF download:** [https://arxiv.org/pdf/2005.14165v4](https://arxiv.org/pdf/2005.14165v4)

---

## Full Entry (Raw XML)

The following is the complete raw XML response from the arXiv API for this paper entry, containing all metadata fields including the full abstract, author list, categories, timestamps, and links.

```xml
<?xml version="1.0" ?>
<feed xmlns:opensearch="http://a9.com/-/spec/opensearch/1.1/" xmlns:arxiv="http://arxiv.org/schemas/atom" xmlns="http://www.w3.org/2005/Atom">
  
  
  <id>https://arxiv.org/api//Pt2IvXEclQIHLRi2yPpm7lLPYk</id>
  
  
  <title>arXiv Query: search_query=&amp;id_list=2005.14165&amp;start=0&amp;max_results=1</title>
  
  
  <updated>2026-05-12T15:18:47Z</updated>
  
  
  <link href="https://arxiv.org/api/query?search_query=&amp;start=0&amp;max_results=1&amp;id_list=2005.14165" type="application/atom+xml"/>
  
  
  <opensearch:itemsPerPage>1</opensearch:itemsPerPage>
  
  
  <opensearch:totalResults>1</opensearch:totalResults>
  
  
  <opensearch:startIndex>0</opensearch:startIndex>
  
  
  <entry>
    
    
    <id>http://arxiv.org/abs/2005.14165v4</id>
    
    
    <title>Language Models are Few-Shot Learners</title>
    
    
    <updated>2020-07-22T19:47:17Z</updated>
    
    
    <link href="https://arxiv.org/abs/2005.14165v4" rel="alternate" type="text/html"/>
    
    
    <link href="https://arxiv.org/pdf/2005.14165v4" rel="related" type="application/pdf" title="pdf"/>
    
    
    <summary>Recent work has demonstrated substantial gains on many NLP tasks and benchmarks by pre-training on a large corpus of text followed by fine-tuning on a specific task. While typically task-agnostic in architecture, this method still requires task-specific fine-tuning datasets of thousands or tens of thousands of examples. By contrast, humans can generally perform a new language task from only a few examples or from simple instructions - something which current NLP systems still largely struggle to do. Here we show that scaling up language models greatly improves task-agnostic, few-shot performance, sometimes even reaching competitiveness with prior state-of-the-art fine-tuning approaches. Specifically, we train GPT-3, an autoregressive language model with 175 billion parameters, 10x more than any previous non-sparse language model, and test its performance in the few-shot setting. For all tasks, GPT-3 is applied without any gradient updates or fine-tuning, with tasks and few-shot demonstrations specified purely via text interaction with the model. GPT-3 achieves strong performance on many NLP datasets, including translation, question-answering, and cloze tasks, as well as several tasks that require on-the-fly reasoning or domain adaptation, such as unscrambling words, using a novel word in a sentence, or performing 3-digit arithmetic. At the same time, we also identify some datasets where GPT-3's few-shot learning still struggles, as well as some datasets where GPT-3 faces methodological issues related to training on large web corpora. Finally, we find that GPT-3 can generate samples of news articles which human evaluators have difficulty distinguishing from articles written by humans. We discuss broader societal impacts of this finding and of GPT-3 in general.</summary>
    
    
    <category term="cs.CL" scheme="http://arxiv.org/schemas/atom"/>
    
    
    <published>2020-05-28T17:29:03Z</published>
    
    
    <arxiv:comment>40+32 pages</arxiv:comment>
    
    
    <arxiv:primary_category term="cs.CL"/>
    
    
    <author>
      
      
      <name>Tom B. Brown</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Benjamin Mann</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Nick Ryder</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Melanie Subbiah</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Jared Kaplan</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Prafulla Dhariwal</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Arvind Neelakantan</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Pranav Shyam</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Girish Sastry</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Amanda Askell</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Sandhini Agarwal</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Ariel Herbert-Voss</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Gretchen Krueger</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Tom Henighan</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Rewon Child</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Aditya Ramesh</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Daniel M. Ziegler</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Jeffrey Wu</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Clemens Winter</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Christopher Hesse</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Mark Chen</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Eric Sigler</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Mateusz Litwin</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Scott Gray</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Benjamin Chess</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Jack Clark</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Christopher Berner</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Sam McCandlish</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Alec Radford</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Ilya Sutskever</name>
      
    
    </author>
    
    
    <author>
      
      
      <name>Dario Amodei</name>
      
    
    </author>
    
  
  </entry>
  

</feed>

```

---

## Abstract (Reference Copy)

For quick reference, the full abstract is reproduced below:

Recent work has demonstrated substantial gains on many NLP tasks and benchmarks by pre-training on a large corpus of text followed by fine-tuning on a specific task. While typically task-agnostic in architecture, this method still requires task-specific fine-tuning datasets of thousands or tens of thousands of examples. By contrast, humans can generally perform a new language task from only a few examples or from simple instructions - something which current NLP systems still largely struggle to do. Here we show that scaling up language models greatly improves task-agnostic, few-shot performance, sometimes even reaching competitiveness with prior state-of-the-art fine-tuning approaches. Specifically, we train GPT-3, an autoregressive language model with 175 billion parameters, 10x more than any previous non-sparse language model, and test its performance in the few-shot setting. For all tasks, GPT-3 is applied without any gradient updates or fine-tuning, with tasks and few-shot demonstrations specified purely via text interaction with the model. GPT-3 achieves strong performance on many NLP datasets, including translation, question-answering, and cloze tasks, as well as several tasks that require on-the-fly reasoning or domain adaptation, such as unscrambling words, using a novel word in a sentence, or performing 3-digit arithmetic. At the same time, we also identify some datasets where GPT-3's few-shot learning still struggles, as well as some datasets where GPT-3 faces methodological issues related to training on large web corpora. Finally, we find that GPT-3 can generate samples of news articles which human evaluators have difficulty distinguishing from articles written by humans. We discuss broader societal impacts of this finding and of GPT-3 in general.

---

## Abstract Word-Level Analysis

The abstract contains **260 words** and **1789 characters** (including spaces). Below is a detailed breakdown of the abstract structure:

### Sentence Breakdown

1. **(27 words)** Recent work has demonstrated substantial gains on many NLP tasks and benchmarks by pre-training on a large corpus of text followed by fine-tuning on a specific task.
2. **(20 words)** While typically task-agnostic in architecture, this method still requires task-specific fine-tuning datasets of thousands or tens of thousands of examples.
3. **(30 words)** By contrast, humans can generally perform a new language task from only a few examples or from simple instructions - something which current NLP systems still largely struggle to do.
4. **(22 words)** Here we show that scaling up language models greatly improves task-agnostic, few-shot performance, sometimes even reaching competitiveness with prior state-of-the-art fine-tuning approaches.
5. **(28 words)** Specifically, we train GPT-3, an autoregressive language model with 175 billion parameters, 10x more than any previous non-sparse language model, and test its performance in the few-shot setting.
6. **(25 words)** For all tasks, GPT-3 is applied without any gradient updates or fine-tuning, with tasks and few-shot demonstrations specified purely via text interaction with the model.
7. **(41 words)** GPT-3 achieves strong performance on many NLP datasets, including translation, question-answering, and cloze tasks, as well as several tasks that require on-the-fly reasoning or domain adaptation, such as unscrambling words, using a novel word in a sentence, or performing 3-digit arithmetic.
8. **(32 words)** At the same time, we also identify some datasets where GPT-3's few-shot learning still struggles, as well as some datasets where GPT-3 faces methodological issues related to training on large web corpora.
9. **(22 words)** Finally, we find that GPT-3 can generate samples of news articles which human evaluators have difficulty distinguishing from articles written by humans.
10. **(13 words)** We discuss broader societal impacts of this finding and of GPT-3 in general.

### Word Frequency Distribution

The 30 most frequent words (excluding very short words) in the abstract:

| Rank | Word | Frequency |
|------|------|-----------|
| 1 | gpt-3 | 6 |
| 2 | tasks | 5 |
| 3 | and | 5 |
| 4 | fine-tuning | 4 |
| 5 | datasets | 4 |
| 6 | language | 4 |
| 7 | few-shot | 4 |
| 8 | with | 4 |
| 9 | nlp | 3 |
| 10 | still | 3 |
| 11 | from | 3 |
| 12 | that | 3 |
| 13 | performance | 3 |
| 14 | model | 3 |
| 15 | the | 3 |
| 16 | many | 2 |
| 17 | large | 2 |
| 18 | text | 2 |
| 19 | task | 2 |
| 20 | task-agnostic | 2 |
| 21 | this | 2 |
| 22 | thousands | 2 |
| 23 | examples | 2 |
| 24 | humans | 2 |
| 25 | can | 2 |
| 26 | which | 2 |
| 27 | any | 2 |
| 28 | well | 2 |
| 29 | some | 2 |
| 30 | where | 2 |

### Character-Level Statistics

- **Total characters (including spaces):** 1789
- **Alphabetic characters:** 1458 (81.5%)
- **Digits:** 13 (0.7%)
- **Whitespace characters:** 259 (14.5%)
- **Punctuation and other:** 59 (3.3%)

### Key Terminology

The abstract contains **153 unique terms** (after lowercasing and removing punctuation). The vocabulary richness ratio (unique/total words) is **58.8%**.

Unique terms (alphabetically sorted, showing first 50):

- 10x, 175, 3-digit, achieves, adaptation
- all, also, and, any, applied
- approaches, architecture, arithmetic, articles, autoregressive
- benchmarks, billion, broader, can, cloze
- competitiveness, contrast, corpora, corpus, current
- datasets, demonstrated, demonstrations, difficulty, discuss
- distinguishing, domain, evaluators, even, examples
- faces, few, few-shot, finally, find
- finding, fine-tuning, followed, for, from
- gains, general, generally, generate, gpt-3
- ... and 103 more unique terms

### Readability Metrics

- **Average word length:** 5.61 characters
- **Average sentence length:** 26.00 words
- **Number of sentences:** 10
- **Number of words:** 260

---

## Paper Context and Significance

The paper titled "Language Models are Few-Shot Learners" (arXiv: `2005.14165v4`) represents a significant contribution to the field of cs.CL. Published on 2020-05-28 and most recently updated on 2020-07-22, this work has been authored by 31 researchers and is classified under 1 subject categories.

This entry has been automatically ingested from the arXiv API to preserve the authentic, unmodified abstract as submitted by the authors. The content above represents the exact text returned by the arXiv API endpoint without any LLM-based summarization or paraphrasing.
