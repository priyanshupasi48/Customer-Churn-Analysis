from pathlib import Path
import pandas as pd


# ==========================================
# 1. DEFINE PROJECT PATHS
# ==========================================

# Find the main project folder
PROJECT_DIR = Path(__file__).resolve().parent.parent

# Path to the raw dataset
INPUT_FILE = PROJECT_DIR / "data" / "raw" / "telco_churn.csv"

# Path to save the cleaned dataset
OUTPUT_FILE = (
    PROJECT_DIR
    / "data"
    / "processed"
    / "telco_churn_cleaned.csv"
)


# ==========================================
# 2. LOAD THE RAW DATASET
# ==========================================

df = pd.read_csv(INPUT_FILE)

print("Raw dataset loaded successfully!")

print("\nFirst five rows:")
print(df.head())

print("\nOriginal dataset shape:")
print(df.shape)


# ==========================================
# 3. CLEAN COLUMN NAMES
# ==========================================

# Remove extra spaces from column names
df.columns = df.columns.str.strip()

# Standardize column names
df.columns = (
    df.columns
    .str.lower()
    .str.replace(" ", "_", regex=False)
)

print("\nColumn names cleaned successfully!")


# ==========================================
# 4. CLEAN TEXT VALUES
# ==========================================

# Remove unnecessary spaces from text columns
text_columns = df.select_dtypes(include=["object"]).columns

for column in text_columns:
    df[column] = df[column].apply(
        lambda value: value.strip()
        if isinstance(value, str)
        else value
    )

# Convert common missing-value indicators to actual missing values
df.replace(
    ["", " ", "NA", "N/A", "NULL", "null", "None", "none"],
    pd.NA,
    inplace=True
)

print("\nText values cleaned successfully!")


# ==========================================
# 5. CHECK MISSING VALUES
# ==========================================

print("\nMissing values before handling:")
print(df.isnull().sum())


# ==========================================
# 6. REMOVE DUPLICATE ROWS
# ==========================================

duplicates_before = df.duplicated().sum()

print("\nDuplicate rows found:", duplicates_before)

df.drop_duplicates(inplace=True)

print("Duplicate rows removed:", duplicates_before)


# ==========================================
# 7. HANDLE MISSING VALUES
# ==========================================

# Fill missing numerical values with the median
numeric_columns = df.select_dtypes(
    include=["number"]
).columns

for column in numeric_columns:
    if df[column].isnull().any():
        df[column] = df[column].fillna(
            df[column].median()
        )

# Fill missing categorical values with the mode
categorical_columns = df.select_dtypes(
    include=["object", "category"]
).columns

for column in categorical_columns:
    if df[column].isnull().any():

        mode_values = df[column].mode(dropna=True)

        if not mode_values.empty:
            df[column] = df[column].fillna(
                mode_values.iloc[0]
            )

print("\nMissing values after handling:")
print(df.isnull().sum())


# ==========================================
# 8. CONVERT TOTALCHARGES TO NUMERIC
# ==========================================

# Some Telco datasets contain blank strings in TotalCharges.
# Convert invalid values to missing values first.

if "totalcharges" in df.columns:

    df["totalcharges"] = pd.to_numeric(
        df["totalcharges"],
        errors="coerce"
    )

    if df["totalcharges"].isnull().any():

        median_value = df["totalcharges"].median()

        if pd.notna(median_value):
            df["totalcharges"] = df["totalcharges"].fillna(
                median_value
            )

print("\nData types after conversion:")
print(df.dtypes)


# ==========================================
# 9. CHECK CUSTOMER IDENTIFIERS
# ==========================================

# CustomerID should not be treated as a numerical measurement.
# Keep it as an identifier.

if "customerid" in df.columns:
    df["customerid"] = df["customerid"].astype("string")


# ==========================================
# 10. CREATE PROCESSED FOLDER IF NEEDED
# ==========================================

OUTPUT_FILE.parent.mkdir(
    parents=True,
    exist_ok=True
)


# ==========================================
# 11. SAVE THE CLEANED DATASET
# ==========================================

df.to_csv(
    OUTPUT_FILE,
    index=False
)

print("\n==========================================")
print("DATA CLEANING COMPLETED SUCCESSFULLY!")
print("==========================================")

print("\nCleaned dataset shape:")
print(df.shape)

print("\nCleaned dataset saved at:")
print(OUTPUT_FILE)


# ==========================================
# 12. FINAL DATA QUALITY CHECKS
# ==========================================

print("\nRemaining missing values:")
print(df.isnull().sum())

print("\nRemaining duplicate rows:")
print(df.duplicated().sum())

print("\nFirst five rows of cleaned dataset:")
print(df.head())