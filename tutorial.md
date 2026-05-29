# Cloud Shell Security Test Tutorial

## Step 1: Environment Check

Welcome to the security test tutorial. This tutorial tests whether Cloud Shell
deep-link parameters allow code execution in the victim's environment.

### Check environment type

Run the following command to check if this is a temporary or persistent environment:

```bash
echo "=== ENVIRONMENT TYPE CHECK ==="
echo "HOME=$HOME"
echo "USER=$USER"
echo "CLOUD_SHELL=$CLOUD_SHELL"
ls -la $HOME/.customize_environment 2>/dev/null && echo "customize_environment EXISTS in HOME" || echo "customize_environment NOT in HOME"
ls -la .customize_environment 2>/dev/null && echo "customize_environment EXISTS in repo" || echo "customize_environment NOT in repo"
echo "=== END CHECK ==="
```

### Check credential availability

```bash
echo "=== CREDENTIAL CHECK ==="
gcloud auth list 2>/dev/null || echo "gcloud auth list FAILED"
gcloud auth print-access-token 2>/dev/null | head -c 20 && echo "...[TRUNCATED]" || echo "NO TOKEN AVAILABLE"
echo "GOOGLE_CLOUD_PROJECT=$GOOGLE_CLOUD_PROJECT"
echo "=== END CREDENTIAL CHECK ==="
```

<walkthrough-editor-open-file filePath="canary.txt">Open the canary file</walkthrough-editor-open-file>

## Step 2: Walkthrough Directive Test

This step tests whether walkthrough directives can trigger code execution.

<walkthrough-editor-open-file filePath=".customize_environment">View customize_environment</walkthrough-editor-open-file>

### Test spotlight directive

<walkthrough-editor-spotlight-pointer spotlightId="menu-terminal-new-terminal">Click here to open a terminal</walkthrough-editor-spotlight-pointer>

## Step 3: Conclusion

If you reached this step, the tutorial rendered successfully.

Check the following:
1. Did `.customize_environment` from the repo execute? Check `/tmp/b4-01-canary.txt`
2. Did `.bashrc` from the repo execute? Check `/tmp/b4-01-bashrc-canary.txt`
3. Were credentials available? Check the output from Step 1.

```bash
echo "=== FINAL CANARY CHECK ==="
cat /tmp/b4-01-canary.txt 2>/dev/null || echo "NO customize_environment canary"
cat /tmp/b4-01-bashrc-canary.txt 2>/dev/null || echo "NO bashrc canary"
cat /tmp/b4-01-envrc-canary.txt 2>/dev/null || echo "NO envrc canary"
echo "=== END FINAL CHECK ==="
```
