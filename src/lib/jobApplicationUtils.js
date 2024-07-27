// src/lib/jobApplicationUtils.js

import { toast } from "svelte-sonner";
// import { appliedJobs } from "../stores/jobStore";
import { appliedJobs } from "../../app/frontend/stores/userStore";

export async function applyForJob(jobId, jobTitle, companyName) {
  const currentState = appliedJobs.update((state) => {
    if (state[jobId]) {
      toast.error(`You have already applied to ${jobTitle} at ${companyName}`);
      return state;
    }
    return state;
  });

  if (currentState[jobId]) return; // If already applied, exit early

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
      appliedJobs.update((state) => {
        state[jobId] = true;
        return state;
      });
      toast.success(`Applied to ${jobTitle} at ${companyName}!`, {
        action: {
          label: "",
          onClick: async () => {
            // You can implement undo functionality here if needed
            console.info("Undo");
          },
        },
      });
    } else {
      const errorData = await response.json();
      toast.error(`Failed to apply: ${errorData.errors.join(", ")}`);
    }
  } catch (error) {
    toast.error(`An error occurred: ${error.message}`);
  }
}
