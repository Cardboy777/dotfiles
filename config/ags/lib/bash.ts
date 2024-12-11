import { exec, execAsync } from "astal";

export function bashRun(command: string, isAsync = false) {
  const func = isAsync ? execAsync : exec;
  return func(["bash", "-c", command]);
}
