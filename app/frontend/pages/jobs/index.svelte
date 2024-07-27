<script lang="ts">
  import { toast } from "svelte-sonner";
  import { Button } from "$lib/components/ui/button/index.js";
  import * as Card from "$lib/components/ui/card/index.js";
  import * as Avatar from "$lib/components/ui/avatar";

  export let jobs;
  // Log the jobs array to check its structure
  // console.log('Jobs:', jobs[0].employer.user.profile_picture);
  async function applyForJob(jobId, jobTitle, companyName) {
    try {
      const response = await fetch("/job_applications", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({
          job_application: {
            job_id: jobId
          }
        })
      });

      if (response.ok) {
        toast.success(`Applied to ${jobTitle} at ${companyName}!`, {
          action: {
            label: "",
            onClick: async () => {
              // You can implement undo functionality here if needed
              console.info("Undo");
            }
          }
        });
        console.log('Applied to job successfully')
      } else {
        const errorData = await response.json();
        toast.error(`Failed to apply: ${errorData.errors.join(", ")}`);
      }
    } catch (error) {
      toast.error(`An error occurred: ${error.message}`);
      console.log("Couldn't apply to job")
    }
  }
</script>

<!-- {#each jobs as job}
  <p>{job.title}</p>
  <p>{job.employer.company_name}</p>
  <p>{job.employer.user.profile_picture}</p>
{/each} -->
<h1 class="mx-auto my-24 text-5xl text-center">Discover the <span class="text-red-500">Best Jobs</span></h1>

<div class="grid grid-cols-1 gap-4">
  {#each jobs as job}
    <Card.Root class="w-full max-w-full overflow-hidden rounded-lg shadow-lg">
        <!-- Avatar -->

        <!-- Card Header -->
        <div class="w-full">
          <Card.Header class="flex p-0 pt-6 mt-4">
            <div class="flex px-4 space-x-6">
              <Avatar.Root class="w-24 h-24">
                <Avatar.Image src="{job.employer.user.profile_picture}" alt="Employer Profile Picture" class="object-cover" />
                <Avatar.Fallback></Avatar.Fallback>
              </Avatar.Root>
              <div class="self-center">
                <Card.Title class="text-xl font-bold">{job.title}</Card.Title>
                <Card.Description class="text-sm">{job.location} . <span class="text-sm">{job.status}</span></Card.Description>
              </div>
            </div>
          </Card.Header>
          <!-- Card Footer -->
          <Card.Footer class="flex justify-end pb-4 border-gray-200">
            <Button href={`/jobs/${job.id}`} variant="outline" class="mr-2">More Details</Button>
            <Button
              class="self-center"
              on:click={() =>
                applyForJob(job.id, job.title, job.employer.company_name)}
              >
              Apply
            </Button>
          </Card.Footer>
        </div>
    </Card.Root>
  {/each}
</div>
