import { toast } from "svelte-sonner";

export async function applyForJob(jobId, jobTitle, companyName) {
  try {
    const response = await fetch("/job_applications", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document
          .querySelector('meta[name="csrf-token"]')
          .getAttribute("content"),
      },
      body: JSON.stringify({
        job_application: {
          job_id: jobId,
        },
      }),
    });

    if (response.ok) {
      toast.success(`Applied to ${jobTitle} at ${companyName}!`);
      return true; // Indicate success
    } else {
      const errorData = await response.json();
      if (response.status === 422 && errorData.message === "already_applied") {
        toast.error(
          `You have already applied to ${jobTitle} at ${companyName}`
        );
      } else {
        toast.error(
          `Failed to apply: ${errorData.errors ? errorData.errors.join(", ") : "Unknown error"}`
        );
      }
      return false; // Indicate failure
    }
  } catch (error) {
    toast.error(`An error occurred: ${error.message}`);
    return false; // Indicate failure
  }
}
