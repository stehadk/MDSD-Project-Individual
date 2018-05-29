/*
 * generated by Xtext 2.13.0
 */
package dk.sdu.mmmi.mdsd.project.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import java.util.zip.ZipInputStream
import java.io.ByteArrayOutputStream
import java.io.ByteArrayInputStream

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class DSLGenerator extends AbstractGenerator {
	
	static final String STATIC_FILES = 'MDSD-sample-master'

	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		fsa.unpackProject
		
		new GUIGenerator(resource, fsa, context)
		new ControllerGenerator(resource, fsa, context)
		new MissionGenerator(resource, fsa, context)
		
		/*
		new InterfaceGenerator(resource, fsa, context);
		new GUIGenerator(resource, fsa, context);
		new ControllerGenerator(resource, fsa, context);
		new ModelGenerator(resource, fsa, context);
		new ProjectGenerator(resource, fsa, context);
		new ExceptionGenerator(resource, fsa, context);
		new MissionGeneratorGenerator(resource, fsa, context);
		*/
	}
	
	def unpackProject(IFileSystemAccess2 fsa) {
		val byte[] buffer = newByteArrayOfSize(1024)
		
		var zis = new ZipInputStream(this.class.getResourceAsStream(STATIC_FILES + '.zip'))
		var ze = zis.nextEntry
		while(ze !== null) {
			var name = ze.name.replace(STATIC_FILES, '')
			println("Generating | Dir: " + ze.isDirectory + " | Name: " + name)
			if (!ze.isDirectory) {
				var baos = new ByteArrayOutputStream()
				var len = 0
				while((len = zis.read(buffer)) > 0) {
					baos.write(buffer, 0, len)
				}
				baos.flush
				fsa.generateFile(name, new ByteArrayInputStream(baos.toByteArray))
				baos.close
			}
			ze = zis.nextEntry
		}
		zis.closeEntry
		zis.close
	}

}
