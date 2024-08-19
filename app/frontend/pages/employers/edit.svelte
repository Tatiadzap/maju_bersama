<script lang="ts">
  import { Button } from "$lib/components/ui/button";
  import * as Card from "$lib/components/ui/card";
  import { Input } from "$lib/components/ui/input";
  import { Label } from "$lib/components/ui/label";
  import { Textarea } from "$lib/components/ui/textarea";
  import { useForm } from "@inertiajs/svelte";

  export let employer = null;
  export let user = null;

  let form = useForm({
    employer: {
      company_name: employer?.company_name || '',
      industry: employer?.industry || '',
      website: employer?.website || '',
      company_description: employer?.company_description || '',
    },
    user: {
      phone: user?.phone || '',
      address: user?.address || '',
      city: user?.city || '',
      state: user?.state || '',
      zip_code: user?.zip_code || '',
      country: user?.country || '',
    }
  });

  function submit() {
    console.log('Submitting form');
    $form.put(`/employers/${employer.id}`);
  }
</script>

<Card.Root>
  <Card.Header>
    <Card.Title>Update Employer Profile</Card.Title>
    <Card.Description>Update your company and contact information.</Card.Description>
  </Card.Header>
  <Card.Content>
    {#if employer && user}
      <form on:submit|preventDefault={submit}>
        <div class="space-y-4">
          <div>
            <Label for="company_name">Company Name</Label>
            <Input id="company_name" bind:value={$form.employer.company_name} placeholder="Company Name" />
            {#if $form.errors['employer.company_name']}
              <div class="text-sm text-red-500">{$form.errors['employer.company_name']}</div>
            {/if}
          </div>

          <div>
            <Label for="industry">Industry</Label>
            <Input id="industry" bind:value={$form.employer.industry} placeholder="Industry" />
            {#if $form.errors['employer.industry']}
              <div class="text-sm text-red-500">{$form.errors['employer.industry']}</div>
            {/if}
          </div>

          <div>
            <Label for="website">Website</Label>
            <Input id="website" bind:value={$form.employer.website} placeholder="Website" />
            {#if $form.errors['employer.website']}
              <div class="text-sm text-red-500">{$form.errors['employer.website']}</div>
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
            <Label for="about">About</Label>
            <Textarea
              id="company_description"
              bind:value={$form.employer.company_description}
              placeholder="Tell us about yourself"
              class="min-h-32"
            />
            {#if $form.errors['employer.company_description']}
              <div class="text-sm text-red-500">{$form.errors['employer.company_description']}</div>
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
