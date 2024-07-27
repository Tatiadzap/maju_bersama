<script lang="ts">
  import { applyForJob } from '$lib/jobApplicationUtils';
  import { Button } from "$lib/components/ui/button/index.js";
  import { appliedJobs } from '../../stores/jobStore';
  import { get } from 'svelte/store';

  export let job;

  // Function to check if a job has been applied
  const isApplied = (jobId) => {
    return get(appliedJobs)[jobId];
  };
</script>

<h1 class="mx-auto my-24 text-5xl text-center">{job.title}</h1>

<div class="flex flex-col items-center">
  <div class="w-full max-w-3xl p-4 rounded-lg shadow-lg">
    <p>{job.description}</p>
    <p>{job.location}</p>
    <p>{job.status}</p>
    <!-- Other job details -->

    <Button
      class="self-center mt-4"
      on:click={() => applyForJob(job.id, job.title, job.employer.company_name)}
      disabled={isApplied(job.id)}
    >
      {isApplied(job.id) ? "Applied" : "Apply"}
    </Button>
  </div>
</div>
