import { AppSearch } from "./app-search/app-search.component";
import { AppHome } from "./app-home/app-home.component";
import { NgModule } from "@angular/core";
import { RouterModule, Routes } from "@angular/router";

const routes: Routes = [
  { path: "", component: AppHome, pathMatch: "full" },
  {
    path: "search",
    component: AppSearch
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule {}
