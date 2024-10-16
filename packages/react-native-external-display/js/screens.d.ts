export type Screen = {
  id: string
  width: number
  height: number
  mirrored?: boolean
}
export type ScreenInfo = {
  [screenId: string]: Screen
}

export function getScreens(): ScreenInfo
