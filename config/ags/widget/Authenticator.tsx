import { bashRun } from "../lib/bash"

const authenticator_command = 'proton-authenticator'

export function Authenticator() {
    return <button
        className="authenticator-tray"
        tooltipMarkup="Open Authenticator for 2F codes"
        onClickRelease={() => bashRun(authenticator_command)}
    >
        <icon icon="keepassxc-dark" />
    </button>
}

