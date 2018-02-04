import { Apollo } from "apollo-angular";
import { map } from "rxjs/operators";
import { Component, OnInit } from "@angular/core";
import gql from "graphql-tag";
import { DocumentNode } from "graphql";
import { Observable } from "rxjs/Observable";
import { AppHomeQuery } from "../graphql-types";
import { InstallationComponent } from "../app-installation/app-installation.component";

const query = require("./app-home.component.graphql");

interface QueryResponse {
  installations: Array<any>;
  loading: boolean;
  decidim: { version: string };
}

@Component({
  selector: "app-home",
  templateUrl: "./app-home.component.html"
})
export class AppHome implements OnInit {
  installations$: Observable<
    Array<{
      url: string;
      version: string;
      currentVersion: string;
    }>
  >;

  constructor(private apollo: Apollo) {}

  ngOnInit() {
    this.installations$ = this.apollo
      .watchQuery<AppHomeQuery>({ query, pollInterval: 10000 })
      .valueChanges.pipe(
        map(({ data }) =>
          data.installations
            .map(installation => ({
              ...installation,
              currentVersion: data.decidim.version
            }))
            .sort((a, b) => (a.name < b.name ? -1 : 1))
        )
      );
  }
}
