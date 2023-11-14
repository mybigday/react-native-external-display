import { ScreenInfo } from "./screens";

type ExternalDisplayOptions = {
    onScreenConnect: () => void;
    onScreenChange: () => void;
    onScreenDisconnect: () => void;
};

export default function useExternalDisplay(options?: ExternalDisplayOptions): ScreenInfo;