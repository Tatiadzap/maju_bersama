<script lang="ts">
  // Import Libraries
  import { Link } from '@inertiajs/svelte';
  import { Card } from '$lib/components/ui/card'
  import * as Avatar from "$lib/components/ui/avatar";
  import { Separator } from "$lib/components/ui/separator";

  // Component Props
  export let employer
  export let user

</script>

<Card class="p-6 mb-4 border-none shadow-none">
  <div class="flex justify-between">
    <Avatar.Root>
      <Avatar.Image src="user.profile_picture" alt="@shadcn"/>
      <Avatar.Fallback>{employer.company_name}</Avatar.Fallback>
    </Avatar.Root>
    <Link href="{employer.id}/edit">Edit profile</Link>
  </div>

  <div>
    <h2 class="mb-4 text-lg font-bold">{employer.company_name}</h2>
    <a href="{employer.website}" class="font-light">Website: {employer.website}</a>
    <p class="font-light">Industry: {employer.industry}</p>
    <p class="font-light">Email: {user.email}</p>
    <p class="font-light">Phone: {user.phone}</p>

    <p class="font-light">Address: {user.address}, {user.city}, {user.state}</p>
  </div>
</Card>

<Card class="p-6 mb-4 border-none shadow-none">
  <div>
    <h1 class="mb-4 text-lg font-bold">About</h1>
    <p class="">{employer.company_description}</p>
  </div>
</Card>
