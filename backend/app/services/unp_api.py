import httpx
import os

class UnpApi:
    def __init__(self):
        self.base_url = os.getenv("API_UNP_URL", "https://grp.nalog.gov.by/grp/rest-api")
        self.client = httpx.AsyncClient(base_url=self.base_url)

    async def get_company_name(self, unp: str) -> str | None:
        try:
            response = await self.client.get(f"/v2/organizations/{unp}")
            response.raise_for_status()
            data = response.json()
            # Assuming the API returns a structure like {"name": "Company Name"}
            return data.get("name")
        except httpx.HTTPStatusError as e:
            print(f"HTTP error fetching UNP {unp}: {e.response.status_code} - {e.response.text}")
            return None
        except httpx.RequestError as e:
            print(f"Request error fetching UNP {unp}: {e}")
            return None
