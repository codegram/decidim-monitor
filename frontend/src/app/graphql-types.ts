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
    // A list of tags associated with this installation
    tags: Array< string | null > | null,
  } | null > | null,
  decidim:  {
    // Decidim's latest released version
    version: string | null,
  } | null,
};

export interface AppSearchQueryVariables {
  version?: string | null,
  tags?: Array< string | null > | null,
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
    // A list of tags associated with this installation
    tags: Array< string | null > | null,
  } | null > | null,
  decidim:  {
    // Decidim's latest released version
    version: string | null,
  } | null,
};
