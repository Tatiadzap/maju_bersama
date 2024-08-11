<script lang="ts">
  import { Button } from "$lib/components/ui/button";
  import * as Card from "$lib/components/ui/card";
  import { Input } from "$lib/components/ui/input";
  import { Label } from "$lib/components/ui/label";
  import { Textarea } from "$lib/components/ui/textarea";
  import { useForm } from "@inertiajs/svelte";

  export let candidate = null;
  export let user = null;

  // Initialize the form with data from props
  let form = useForm({
    candidate: {
      first_name: candidate?.first_name || '',
      last_name: candidate?.last_name || '',
      date_of_birth: candidate?.date_of_birth || '',
      languages: candidate?.languages || [],
    },
    user: {
      phone: user?.phone || '',
      address: user?.address || '',
      city: user?.city || '',
      state: user?.state || '',
      zip_code: user?.zip_code || '',
      country: user?.country || '',
      bio: user?.bio || '',
    }
  });

  function submit() {
    console.log('Submitting form');
    $form.put(`/candidates/${candidate.id}`);
  }
</script>

<Card.Root>
  <Card.Header>
    <Card.Title>Update Profile</Card.Title>
    <Card.Description>Update your personal and contact information.</Card.Description>
  </Card.Header>
  <Card.Content>
    {#if candidate && user}
      <form on:submit|preventDefault={submit}>
        <div class="space-y-4">
          <div>
            <Label for="first_name">First Name</Label>
            <Input id="first_name" bind:value={$form.candidate.first_name} placeholder="First Name" />
            {#if $form.errors['candidate.first_name']}
              <div class="text-sm text-red-500">{$form.errors['candidate.first_name']}</div>
            {/if}
          </div>

          <div>
            <Label for="last_name">Last Name</Label>
            <Input id="last_name" bind:value={$form.candidate.last_name} placeholder="Last Name" />
            {#if $form.errors['candidate.last_name']}
              <div class="text-sm text-red-500">{$form.errors['candidate.last_name']}</div>
            {/if}
          </div>

          <div>
            <Label for="date_of_birth">Date of Birth</Label>
            <Input id="date_of_birth" type="date" bind:value={$form.candidate.date_of_birth} />
            {#if $form.errors['candidate.date_of_birth']}
              <div class="text-sm text-red-500">{$form.errors['candidate.date_of_birth']}</div>
            {/if}
          </div>

          <div>
            <Label for="phone">Phone</Label>
            <Input id="phone" bind:value={$form.user.phone} placeholder="Phone" />
            {#if $form.errors['user.phone']}
              <div class="text-sm text-red-500">{$form.errors['user.phone']}</div>
            {/if}
          </div>

          <div>
            <Label for="address">Address</Label>
            <Input id="address" bind:value={$form.user.address} placeholder="Address" />
            {#if $form.errors['user.address']}
              <div class="text-sm text-red-500">{$form.errors['user.address']}</div>
            {/if}
          </div>

          <div>
            <Label for="city">City</Label>
            <Input id="city" bind:value={$form.user.city} placeholder="City" />
            {#if $form.errors['user.city']}
              <div class="text-sm text-red-500">{$form.errors['user.city']}</div>
            {/if}
          </div>

          <div>
            <Label for="state">State</Label>
            <Input id="state" bind:value={$form.user.state} placeholder="State" />
            {#if $form.errors['user.state']}
              <div class="text-sm text-red-500">{$form.errors['user.state']}</div>
            {/if}
          </div>

          <div>
            <Label for="zip_code">Zip Code</Label>
            <Input id="zip_code" bind:value={$form.user.zip_code} placeholder="Zip Code" />
            {#if $form.errors['user.zip_code']}
              <div class="text-sm text-red-500">{$form.errors['user.zip_code']}</div>
            {/if}
          </div>

          <div>
            <Label for="country">Country</Label>
            <Input id="country" bind:value={$form.user.country} placeholder="Country" />
            {#if $form.errors['user.country']}
              <div class="text-sm text-red-500">{$form.errors['user.country']}</div>
            {/if}
          </div>

          <div class="grid gap-3">
            <Label for="bio">Bio</Label>
            <Textarea
              id="bio"
              bind:value={$form.user.bio}
              placeholder="Tell us about yourself"
              class="min-h-32"
            />
            {#if $form.errors['user.bio']}
              <div class="text-sm text-red-500">{$form.errors['user.bio']}</div>
            {/if}
          </div>

          <div>
            <Label for="languages">Languages</Label>
            <Input id="languages" bind:value={$form.candidate.languages} placeholder="Languages (comma separated)" />
            {#if $form.errors['candidate.languages']}
              <div class="text-sm text-red-500">{$form.errors['candidate.languages']}</div>
            {/if}
          </div>
        </div>

        <!-- Submit button inside the form -->
        <Card.Footer class="px-0 py-4 border-t">
          <Button type="submit" disabled={$form.processing}>Save</Button>
        </Card.Footer>
      </form>
    {:else}
      <p>Loading...</p> <!-- Handle case where data is not yet available -->
    {/if}
  </Card.Content>
</Card.Root>
