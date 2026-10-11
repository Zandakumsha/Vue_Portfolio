const configuredBase = import.meta.env.VITE_API_BASE_URL || '/api'
const API_BASE = configuredBase.replace(/\/+$/, '')

async function readResponse(response) {
  const contentType = response.headers.get('content-type') || ''
  if (contentType.includes('application/json')) {
    return response.json()
  }

  const text = await response.text()
  return text ? { message: text } : {}
}

export async function apiRequest(path, options = {}) {
  const normalizedPath = path.startsWith('/') ? path : `/${path}`
  let response

  try {
    response = await fetch(`${API_BASE}${normalizedPath}`, {
      ...options,
      headers: {
        Accept: 'application/json',
        ...(options.body ? { 'Content-Type': 'application/json' } : {}),
        ...(options.headers || {}),
      },
    })
  } catch (error) {
    const detail = error instanceof Error ? error.message : 'Network request failed'
    throw new Error(
      `Could not reach the portfolio API (${API_BASE}${normalizedPath}). Make sure the backend is running on port 5000. ${detail}`,
    )
  }

  const data = await readResponse(response).catch(() => ({}))
  if (!response.ok) {
    throw new Error(data.message || `API request failed with status ${response.status}.`)
  }

  return data
}
