# Behind the Label
**Hazardous chemicals in cosmetics: US reports vs. EU rules, and which ingredients really work for which skin.**

🚧 *Final project for the WBS Coding School Data Analytics & AI programme (November 2026).*

## Question
Which hazardous chemicals do cosmetics companies report and remove, how does that compare with EU rules,
and can ingredient chemistry explain which products work for which skin?

## Data
| Source | Content | Licence |
|---|---|---|
| [California Safe Cosmetics Program (CDPH)](https://lab.data.ca.gov/dataset/chemicals-in-cosmetics) | Hazardous chemicals reported in ~37,000 cosmetic products, 2009–2020 | CC BY |
| [EU CosIng database](https://ec.europa.eu/growth/tools-databases/cosing/) | Banned/restricted substances (Annexes II–VI) and ingredient functions | EU public data |
| [Sephora Products and Skincare Reviews](https://www.kaggle.com/datasets/nadyinky/sephora-products-and-skincare-reviews) (Nady Inky, Kaggle) | 8,494 products, 1.1 million skincare reviews | CC BY 4.0 |

Raw data is not stored in this repository; download it from the links above into `data/raw/`.

## Tools
Python (pandas, scipy, SQLAlchemy, matplotlib/seaborn) · SQL (MySQL) · Tableau Public

## Progress
- [x] Raw data checked (`notebook/00_check_files.ipynb`)
- [x] California data cleaned (`notebook/01_clean_california.ipynb`)
- [x] EU CosIng data cleaned and matched to California (`notebook/02_clean_cosing.ipynb`)
- [x] Sephora data cleaned, ingredients matched to CosIng (`notebook/03_clean_sephora.ipynb`)
- [x] MySQL database: 9 tables, load script and EU-status function (`notebook/04_sql_load.ipynb`, `sql/`)
- [x] Exploratory analysis and charts (`notebook/05_exploratory_data_analysis.ipynb`)
- [x] Hypothesis tests H1 and H4 (`notebook/06_hypothesis_tests.ipynb`)
- [x] Hypothesis tests H2 and H3: skin type and ingredient functions (`notebook/07_sephora_tests.ipynb`)
- [x] Export of flat files for Tableau (`notebook/08_tableau_export.ipynb`)
- [ ] Tableau Public dashboard: safety page and skin-type page (link follows)
- [ ] Presentation (19 November 2026)

## Findings
**California reports vs. EU rules**
- 114,381 reports, 36,972 products, 635 companies, 134 chemicals. Titanium dioxide is in about 87% of products, so most analyses are shown without it.
- 37 chemicals (by CAS number) are banned in the EU (Annex II) and 20 more are restricted (Annex III).
- 845 reports, 455 products and 84 companies involve an EU-banned chemical.
- Many banned hits are impurities (e.g. 1,4-dioxane, ethylene oxide, nitrosamines) that the EU only tolerates as unavoidable traces. 1,4-dioxane forms as a by-product when ethoxylated ingredients are made.
- Banned chemicals show up mostly in hair care, skin care, makeup and nails. One company's batch report matters here: without La Prairie, skin care drops from 119 to 70 banned products and hair care becomes the top category (a product can belong to several categories).
- The benzophenone in these reports is benzophenone itself (CAS 119-61-9), not the UV filter benzophenone-3, which is why chemicals are matched by CAS number and not by name.

**H1: Are chemicals banned in the EU removed more often? (chi-square test)**
- Without titanium dioxide, EU-banned chemicals were removed more often: 16.7% vs. 5.9% of reports (17.5% vs. 9.0% when counting each product-chemical pair once).
- The difference is statistically significant and holds in all robustness checks (odds ratio about 1.8 to 3.3), but the effect is modest (Cramér's V 0.05 to 0.10). This is an association, not proof of cause.
- One company (La Prairie) reported 188 of the 845 banned reports in 2016, mostly benzophenone, and rarely removed them. Without this company the removal rate of banned chemicals is 19.2% (not banned: 5.9%), so the result does not depend on one company.

**H4 (exploratory): Do big companies remove more?**
- Inconclusive: the result changes with the definition of a "big" company, so no claim is made.

**H2 and H3: Skin type, ingredient functions and ratings (Sephora, 2,420 skincare products)**
- 96% of ingredient mentions were matched to CosIng names. 90% of the 1.09 million reviews have a skin type.
- H2: ratings differ only negligibly between skin types (epsilon squared 0.0001). Ratings are strongly skewed to 5 stars, so rank-based tests are used.
- H3: not supported. I predicted that humectant- and emollient-rich products are rated better by dry skin and anti-sebum products better by oily skin. For all four ingredient functions the 95% bootstrap interval of the difference includes zero. Broad ingredient functions do not explain skin-type-specific ratings in this data.

## Limitations
- California reports end in June 2020; the Sephora reviews run until March 2023. The two sources are linked by ingredient, not by date.
- 2009–2010 is the initial reporting wave, and 2016 is dominated by one company's batch report, so counts per year are not a trend.
- "Banned in the EU" does not mean illegal in California, and a report does not mean the chemical is harmful at the amount in the product.
- CosIng function labels say what an ingredient can do, not how much of it is in a product.
- Skin type is self-reported, and reviews are not independent (446,491 authors wrote 982,854 reviews).
- Company counts use the company name (two companies appear with two IDs each).

## Repository structure
- `notebook/` – analysis notebooks (numbered in the order they were run)
- `sql/` – database schema, indexes and the EU-status function
- `images/` – charts used in the README and the presentation
- `data/` – not included (raw data from the links above; clean files are created by the notebooks)

## Author
Dr. Simindokht Gol Kar – PhD chemist (inorganic/materials chemistry) using data to support product-safety and R&D decisions.
[LinkedIn](https://www.linkedin.com/in/simindokhtgolkar)