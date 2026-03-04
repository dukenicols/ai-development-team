# Delegate Task to AI Development Team

When the user runs `/delegate`, follow this workflow:

1. **Invoke the user-proxy agent** with the user's request using the Task tool:
   ```
   Task({
     subagent_type: "user-proxy",
     description: "Interpret user request",
     prompt: "<user's request here>. Read communication/domains/ for existing context. Write structured requirements to communication/messages/ then invoke the project-manager agent."
   })
   ```

2. The user-proxy will:
   - Clarify requirements if needed
   - Write requirements to `communication/messages/`
   - Invoke the project-manager

3. The project-manager will:
   - Break requirements into tasks in `communication/tasks/`
   - Invoke specialist agents via Task tool (in parallel when possible)
   - Monitor completion and report results

4. Report the final results to the user with a summary of:
   - Tasks completed
   - Files created/modified
   - Any blockers or issues encountered

## Usage
```
/delegate Add user authentication with email and OAuth
/delegate Implement the file upload API endpoint
/delegate Build the dashboard with charts and filtering
```
