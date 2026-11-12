# Behind the Label
**Hazardous chemicals in cosmetics: US reports vs. EU rules, and which ingredients really work for which skin.**

🚧 *Work in progress – final project for the WBS Coding School Data Analytics & AI programme (November 2026).*

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
- [x] MySQL database: 9
- [ ]  tables, load script and EU-status function (`notebook/04_sql_load.ipynb`, `sql/`)
- [x] Exploratory analysis and charts (`notebook/05_exploratory_data_analysis.ipynb`)
- [x] Hypothesis tests H1 and H4 (`notebook/06_hypothesis_tests.ipynb`)
- [ ] Hypothesis tests H2 and H3 (skin type, ingredient functions)
- [ ] Tableau dashboard (safety page, skin-type page)
- [ ] Presentation (19 November 2026)

## Findings so far
**California reports vs. EU rules**
- 114,381 reports, 36,972 products, 635 companies, 134 chemicals. Titanium dioxide is in about 87% of products.
- 37 of the 107 chemicals with a CAS number are banned in the EU (Annex II); 20 more are restricted (Annex III).
- 845 reports, 455 products and 86 companies are affected.
- Many banned hits are impurities (e.g. 1,4-dioxane, ethylene oxide, nitrosamines) that the EU only tolerates as unavoidable traces.

**H1: Are chemicals banned in the EU removed more often? (chi-square test)**
- Without titanium dioxide, EU-banned chemicals were removed from products more often: 16.7% vs. 5.9% of reports (17.5% vs. 9.0% when counting each product-chemical pair once).
- The difference is statistically significant and holds in all robustness checks (odds ratio about 1.8 to 3.3), but the effect is modest (Cramér's V 0.05 to 0.10). This is an association, not proof of cause.

**H4 (exploratory): Do big companies remove more?**
- Inconclusive: the result changes with the definition of a "big" company, so no claim is made.

**Sephora ingredients**
- 2,420 skincare products, 87,660 ingredient mentions; 96% of mentions were matched to CosIng names.
- 90% of the 1.09 million reviews have a skin type (combination, dry, normal, oily). Ratings are strongly skewed to 5 stars, so rank-based tests are used.

## Limitations
- California reports end in June 2020; the Sephora reviews run until March 2023. The two sources are linked by ingredient, not by date.
- 2009–2010 is the initial reporting wave, so early removal rates are not comparable with later years.
- "Banned in the EU" does not mean illegal in California, and a report does not mean the chemical is harmful at the amount in the product.
- Skin type is self-reported by the reviewers.

## Repository structure
- `notebook/` – analysis notebooks (numbered in the order they were run)
- `sql/` – database schema, indexes and the EU-status function
- `images/` – charts used in the README and the presentation
- `data/` – not included (raw data from the links above; clean files are created by the notebooks)

## Author
Dr. Simindokht Gol Kar – PhD chemist (inorganic/materials chemistry) using data to support product-safety and R&D decisions.
[LinkedIn](https://www.linkedin.com/in/simindokhtgolkar)