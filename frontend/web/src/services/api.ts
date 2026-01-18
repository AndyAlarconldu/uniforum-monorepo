const IDENTITY_API = import.meta.env.VITE_IDENTITY_API;

export async function login(email: string, password: string) {
  const response = await fetch(`${IDENTITY_API}/login`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ email, password }),
  });

  if (!response.ok) {
    throw new Error("Login failed");
  }

  return response.json();
}
