import { bashRun } from "../lib/bash"

export function EnteAuth() {
    return <button
        className="ente-auth"
        tooltipMarkup="Open Ente Auth for 2F codes"
        onClickRelease={() => bashRun("enteauth")}
    >
        <icon icon="keepassxc-dark" />
    </button>
}

