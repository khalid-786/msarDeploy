# =========================
# Angular build
# =========================
FROM node:20 AS angular-build
WORKDIR /app

COPY MsarFrontEnd/package*.json ./
RUN npm ci --legacy-peer-deps

COPY MsarFrontEnd/ .
RUN npx ng build MsarFrontEnd --configuration production


# =========================
# .NET build
# =========================
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY . .

# restore
RUN dotnet restore MsarBackEnd/WepAPI/WepAPI.csproj

# publish
RUN dotnet publish MsarBackEnd/WepAPI/WepAPI.csproj -c Release -o /app/publish


# =========================
# Runtime
# =========================
FROM mcr.microsoft.com/dotnet/aspnet:10.0
WORKDIR /app

COPY --from=build /app/publish .

# Angular
COPY --from=angular-build /app/dist/MsarFrontEnd/browser /app/wwwroot
ENV ASPNETCORE_URLS=http://+:80


EXPOSE 80

ENTRYPOINT ["dotnet", "WepAPI.dll"]