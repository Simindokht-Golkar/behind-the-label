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
| [Sephora Products and Skincare Reviews](https://www.kaggle.com/datasets/nadyinky/sephora-products-and-skincare-reviews) (Nady Inky, Kaggle) | 8,494 products, 1.1 million reviews | CC BY 4.0 |

Raw data is not stored in this repository; download it from the links above into `data/raw/`.

## Tools
Python (pandas, scipy, matplotlib/seaborn) · SQL (MySQL) · Tableau Public

## Progress
- [x] Raw data checked (`notebook/00_check_files.ipynb`)
- [x] California data cleaned (`notebook/01_clean_california.ipynb`)
- [x] EU CosIng data cleaned and matched to California (`notebook/02_clean_cosing.ipynb`)
- [X] SQL database
- [ ] Analysis and hypothesis tests
- [ ] Tableau dashboard

## First findings (preliminary)
- 37 of the chemicals reported in California cosmetics are banned in the EU (Annex II); 20 more are restricted (Annex III).
- 845 reports, 455 products and 86 companies are affected.
- Chemicals banned in the EU were removed from products more often (16.7%) than the others (6.0%, without titanium dioxide). Statistical testing follows.
- Many banned hits are impurities (e.g. 1,4-dioxane, benzene) that the EU only tolerates as unavoidable traces.

## Author
Dr. Simindokht Gol Kar – PhD chemist (inorganic/materials chemistry) using data to support product-safety and R&D decisions.
[LinkedIn](https://www.linkedin.com/in/simindokhtgolkar)