const FALLBACK = "1.110.1"

export async function getVSCodeVersion() {
  await Promise.resolve()
  return process.env.VSCODE_VERSION || FALLBACK
}
