/*
 * generated by Xtext 2.13.0
 */
package dk.sdu.mmmi.mdsd.project.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import dk.sdu.mmmi.mdsd.project.dSL.Expression
import dk.sdu.mmmi.mdsd.project.dSL.Plus
import dk.sdu.mmmi.mdsd.project.dSL.Minus
import dk.sdu.mmmi.mdsd.project.dSL.Mult
import dk.sdu.mmmi.mdsd.project.dSL.Div
import dk.sdu.mmmi.mdsd.project.dSL.Num

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class DSLGenerator extends AbstractGenerator {

	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
//		fsa.generateFile('greetings.txt', 'People to greet: ' + 
//			resource.allContents
//				.filter(Greeting)
//				.map[name]
//				.join(', '))


		new GUIGenerator(resource, fsa, context);
		new ControllerGenerator(resource, fsa, context);
		new ModelGenerator(resource, fsa, context);
		new ProjectGenerator(resource, fsa, context);
		
	}
	
	// Ulriks display function 
	def String displayExp(Expression exp) {
		"("+switch exp {
			Plus: exp.left.displayExp+"+"+exp.right.displayExp
			Minus: exp.left.displayExp+"-"+exp.right.displayExp
			Mult: exp.left.displayExp+"*"+exp.right.displayExp
			Div: exp.left.displayExp+"/"+exp.right.displayExp
			Num: Integer.toString(exp.value)
			default: throw new Error("Invalid expression")
		}+")"
	}

}
