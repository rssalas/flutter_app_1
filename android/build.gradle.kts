buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:7.3.0") // Asegúrate de usar la versión más reciente o la compatible con tu proyecto
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.7.10") // Asegúrate de usar la versión de Kotlin que estés utilizando
        classpath("com.google.gms:google-services:4.4.2") // Agregamos el classpath del plugin de Google Services
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}