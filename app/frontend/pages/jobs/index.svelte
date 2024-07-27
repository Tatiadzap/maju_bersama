<script lang="ts">
  import { toast } from "svelte-sonner";
  import { Button } from "$lib/components/ui/button/index.js";
  import * as Card from "$lib/components/ui/card/index.js";
  import * as Avatar from "$lib/components/ui/avatar";

  export let jobs;
  // Log the jobs array to check its structure
  // console.log('Jobs:', jobs[0].employer.user.profile_picture);
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
            <Button variant="outline" class="mr-2">More Details</Button>
            <Button
              class="self-center"
              on:click={() =>
                toast.success(`Applied to ${job.title} at ${job.employer.company_name}!`, {
                  description: "Sunday, December 03, 2023 at 9:00 AM",
                  action: {
                    // label: "Undo",
                    onClick: () => console.info("Undo")
                  }
                })}
            >
              Apply
            </Button>
          </Card.Footer>
        </div>
    </Card.Root>
  {/each}
</div>
