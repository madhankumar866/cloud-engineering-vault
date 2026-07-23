
---

# 📂 Titanic ML API – Repo Structure

```
titanic-ml-api/
│── .github/
│   └── workflows/
│       └── ci.yml              # CI/CD pipeline
│
│── notebooks/
│   └── titanic_eda.ipynb       # Data exploration & baseline model
│
│── src/
│   ├── data/
│   │   └── preprocess.py       # Preprocessing (missing values, encoding)
│   ├── models/
│   │   ├── train.py            # Training script
│   │   └── predict.py          # Load model & predict
│   ├── api/
│   │   └── main.py             # FastAPI app
│   └── utils/
│       └── logger.py           # Logging config
│
│── tests/
│   └── test_api.py             # Unit test for API
│
│── Dockerfile
│── requirements.txt
│── README.md
│── .gitignore

```

---

# ⚙️ Core Files

### ✅ `src/data/preprocess.py`

```python
import pandas as pd
from sklearn.model_selection import train_test_split

def load_and_preprocess(path: str):
    df = pd.read_csv(path)
    df = df.drop(columns=["Name", "Ticket", "Cabin"])
    df = pd.get_dummies(df, columns=["Sex", "Embarked"], drop_first=True)
    X = df.drop("Survived", axis=1)
    y = df["Survived"]
    return train_test_split(X, y, test_size=0.2, random_state=42)

```

---

### ✅ `src/models/train.py`

```python
import joblib
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
from src.data.preprocess import load_and_preprocess

def train():
    X_train, X_test, y_train, y_test = load_and_preprocess("data/titanic.csv")
    model = RandomForestClassifier(n_estimators=100, random_state=42)
    model.fit(X_train, y_train)

    preds = model.predict(X_test)
    acc = accuracy_score(y_test, preds)
    print(f"Accuracy: {acc:.2f}")

    joblib.dump(model, "model.pkl")
    print("✅ Model saved at model.pkl")

if __name__ == "__main__":
    train()

```

---

### ✅ `src/models/predict.py`

```python
import joblib
import pandas as pd

model = joblib.load("model.pkl")

def predict(input_data: dict):
    df = pd.DataFrame([input_data])
    return int(model.predict(df)[0])

```

---

### ✅ `src/api/main.py` (FastAPI App)

```python
from fastapi import FastAPI
from src.models.predict import predict

app = FastAPI(title="Titanic Survival API")

@app.get("/")
def root():
    return {"message": "Titanic ML API is running 🚢"}

@app.post("/predict")
def predict_survival(data: dict):
    result = predict(data)
    return {"survived": bool(result)}

```

---

### ✅ `tests/test_api.py`

```python
from fastapi.testclient import TestClient
from src.api.main import app

client = TestClient(app)

def test_root():
    response = client.get("/")
    assert response.status_code == 200
    assert "Titanic" in response.json()["message"]

def test_predict():
    payload = {
        "Pclass": 3,
        "Age": 22,
        "SibSp": 1,
        "Parch": 0,
        "Fare": 7.25,
        "Sex_male": 1,
        "Embarked_S": 1
    }
    response = client.post("/predict", json=payload)
    assert response.status_code == 200
    assert "survived" in response.json()

```

---

### ✅ `Dockerfile`

```docker
FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["uvicorn", "src.api.main:app", "--host", "0.0.0.0", "--port", "8000"]

```

---

### ✅ `requirements.txt`

```
fastapi
uvicorn
pandas
scikit-learn
joblib
pytest

```

---

### ✅ `.github/workflows/ci.yml`

```yaml
name: CI Pipeline

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: "3.10"

      - name: Install dependencies
        run: pip install -r requirements.txt

      - name: Run tests
        run: pytest tests/

```

---

# 🚀 Quick Start

```bash
# Train model
python src/models/train.py

# Run FastAPI
uvicorn src.api.main:app --reload

# Test API
curl -X POST "<http://127.0.0.1:8000/predict>" \
  -H "Content-Type: application/json" \
  -d '{"Pclass":3,"Age":22,"SibSp":1,"Parch":0,"Fare":7.25,"Sex_male":1,"Embarked_S":1}'

```

---

⚡ This repo will give you:

- **ML training script** (scikit-learn)
- **Serving API** (FastAPI)
- **Dockerized deployment**
- **CI/CD pipeline (tests + linting)**
- **Professional repo structure**

---

👉 Do you want me to **zip this repo and give you a ready-to-run starter project** (so you just `git init` + push to GitHub), or would you prefer I just write you a **step-by-step guide to set it up locally**?

ChatGPT can make mistakes. Check important info. See Cookie Preferences.