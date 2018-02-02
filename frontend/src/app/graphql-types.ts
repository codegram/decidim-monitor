/* tslint:disable */
//  This file was automatically generated and should not be edited.

export interface AppHomeQuery {
  // Get all the installations
  installations:  Array< {
    // The installation's name
    name: string | null,
    // The installation's URL
    url: string | null,
    // The installation's repo URL
    repo: string | null,
    // Decidim's installed version
    version: string | null,
    // Whether the installation is maintained by codegram or not
    codegram: boolean | null,
  } | null > | null,
  decidim:  {
    // Decidim's latest released version
    version: string | null,
  } | null,
};

export interface AppSearchQueryVariables {
  version?: string | null,
};

export interface AppSearchQuery {
  // Get all the installations
  installations:  Array< {
    // The installation's name
    name: string | null,
    // The installation's URL
    url: string | null,
    // The installation's repo URL
    repo: string | null,
    // Decidim's installed version
    version: string | null,
    // Whether the installation is maintained by codegram or not
    codegram: boolean | null,
  } | null > | null,
  decidim:  {
    // Decidim's latest released version
    version: string | null,
  } | null,
};
